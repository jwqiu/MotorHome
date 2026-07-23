using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Models;
using MotorHome.Api.Services;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EnquiriesController(MotorHomeDbContext dbContext, EmailService emailService, ILogger<EnquiriesController> logger) : ControllerBase
{
    [HttpGet("exchange-listings/{userId}")]
    public async Task<ActionResult<ListingSummaryResponse[]>> GetExchangeListings(
        Guid userId,
        [FromQuery] int? excludeListingId,
        CancellationToken cancellationToken)
    {
        if (userId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("User id is required."));
        }

        var userExists = await dbContext.Users
            .AsNoTracking()
            .AnyAsync(currentUser => currentUser.Id == userId, cancellationToken);

        if (!userExists)
        {
            return NotFound(new ErrorResponse("User was not found."));
        }

        var query = dbContext.Listings
            .AsNoTracking()
            .Where(currentListing =>
                currentListing.OwnerId == userId &&
                currentListing.Status == "active");

        if (excludeListingId.HasValue)
        {
            query = query.Where(currentListing => currentListing.Id != excludeListingId.Value);
        }

        var listings = await query
            .OrderByDescending(currentListing => currentListing.CreatedAt)
            .Select(currentListing => ListingSummaryResponse.FromListing(currentListing))
            .ToArrayAsync(cancellationToken);

        return Ok(listings);
    }

    [HttpGet("user/{userId}")]
    public async Task<ActionResult<UserEnquiriesResponse>> GetUserEnquiries(
        Guid userId,
        CancellationToken cancellationToken)
    {
        if (userId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("User id is required."));
        }

        var userExists = await dbContext.Users
            .AsNoTracking()
            .AnyAsync(currentUser => currentUser.Id == userId, cancellationToken);

        if (!userExists)
        {
            return NotFound(new ErrorResponse("User was not found."));
        }

        var enquiries = await dbContext.Enquiries
            .AsNoTracking()
            .Where(currentEnquiry => currentEnquiry.SenderId == userId || currentEnquiry.ReceiverId == userId)
            .OrderByDescending(currentEnquiry => currentEnquiry.CreatedAt)
            .ToListAsync(cancellationToken);

        var listingIds = enquiries
            .SelectMany(currentEnquiry => new[] { currentEnquiry.ListingId, currentEnquiry.OfferedListingId ?? 0 })
            .Where(currentId => currentId > 0)
            .Distinct()
            .ToArray();

        var userIds = enquiries
            .SelectMany(currentEnquiry => new[] { currentEnquiry.SenderId, currentEnquiry.ReceiverId })
            .Distinct()
            .ToArray();

        var listingsById = await dbContext.Listings
            .AsNoTracking()
            .Where(currentListing => listingIds.Contains(currentListing.Id))
            .ToDictionaryAsync(currentListing => currentListing.Id, cancellationToken);

        var usersById = await dbContext.Users
            .AsNoTracking()
            .Where(currentUser => userIds.Contains(currentUser.Id))
            .ToDictionaryAsync(currentUser => currentUser.Id, cancellationToken);

        var sent = enquiries
            .Where(currentEnquiry => currentEnquiry.SenderId == userId)
            .Select(currentEnquiry => UserEnquiryItemResponse.FromSentEnquiry(
                currentEnquiry,
                listingsById,
                usersById))
            .ToArray();

        var received = enquiries
            .Where(currentEnquiry =>
                currentEnquiry.ReceiverId == userId &&
                !currentEnquiry.Status.Equals("Cancelled", StringComparison.OrdinalIgnoreCase))
            .Select(currentEnquiry => UserEnquiryItemResponse.FromReceivedEnquiry(
                currentEnquiry,
                listingsById,
                usersById))
            .ToArray();

        return Ok(new UserEnquiriesResponse(sent, received));
    }

    [HttpGet("status")]
    public async Task<ActionResult<EnquiryStatusResponse>> GetEnquiryStatus(
        [FromQuery] int listingId,
        [FromQuery] Guid senderId,
        CancellationToken cancellationToken)
    {
        if (listingId <= 0 || senderId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("Listing and sender user id are required."));
        }

        var hasPendingEnquiry = await dbContext.Enquiries
            .AsNoTracking()
            .AnyAsync(currentEnquiry =>
                currentEnquiry.ListingId == listingId &&
                currentEnquiry.SenderId == senderId &&
                currentEnquiry.Status == "Pending",
                cancellationToken);

        return Ok(new EnquiryStatusResponse(hasPendingEnquiry));
    }

    [HttpPost]
    public async Task<ActionResult<EnquiryResponse>> SubmitEnquiry(
        SubmitEnquiryRequest request,
        CancellationToken cancellationToken)
    {
        if (
            request.ListingId <= 0 ||
            request.SenderId == Guid.Empty ||
            !HasText(request.SenderName) ||
            !HasText(request.Message) ||
            !request.DisclaimerAccepted)
        {
            return BadRequest(new ErrorResponse("Listing, sender user id, name, message, and disclaimer acceptance are required."));
        }

        var listing = await dbContext.Listings
            .FirstOrDefaultAsync(currentListing => currentListing.Id == request.ListingId, cancellationToken);

        if (listing is null)
        {
            return NotFound(new ErrorResponse("Listing was not found."));
        }

        var sender = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Id == request.SenderId, cancellationToken);

        if (sender is null)
        {
            return NotFound(new ErrorResponse("Sender account was not found."));
        }

        var receiver = await dbContext.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(currentUser => currentUser.Id == listing.OwnerId, cancellationToken);

        if (receiver is null)
        {
            return NotFound(
                new ErrorResponse(
                    "Listing owner account was not found."));
        }

        if (receiver.Id == sender.Id)
        {
            return BadRequest(
                new ErrorResponse(
                    "You cannot send an enquiry about your own listing."));
        }

        var now = DateTimeOffset.UtcNow;
        var enquiry = new Enquiry
        {
            ListingId = listing.Id,
            SenderId = sender.Id,
            ReceiverId = listing.OwnerId,
            OfferedListingId = request.OfferedListingId,
            EnquiryType = HasText(request.EnquiryType) ? request.EnquiryType.Trim() : "Direct Exchange",
            Status = "Pending",
            Message = request.Message.Trim(),
            SenderEmailSnapshot = sender.Email,
            DisclaimerAccepted = request.DisclaimerAccepted,
            DateSent = DateOnly.FromDateTime(now.UtcDateTime),
            CreatedAt = now,
            UpdatedAt = now
        };

        dbContext.Enquiries.Add(enquiry);
        await dbContext.SaveChangesAsync(cancellationToken);

        try
        {
            await emailService.SendEnquiryNotificationAsync(
                receiver.Email,
                receiver.Username,
                sender.Username,
                listing.Title,
                cancellationToken);
        }
        catch (Exception exception)
            when (!cancellationToken.IsCancellationRequested)
        {
            logger.LogError(
                exception,
                "Failed to send notification email for enquiry {EnquiryId}.",
                enquiry.Id);
        }

        return Created($"/api/enquiries/{enquiry.Id}", EnquiryResponse.FromEnquiry(enquiry));
    }

    [HttpPost("{id}/cancel")]
    public async Task<ActionResult<EnquiryResponse>> CancelEnquiry(
        int id,
        CancelEnquiryRequest request,
        CancellationToken cancellationToken)
    {
        var enquiry = await dbContext.Enquiries
            .FirstOrDefaultAsync(currentEnquiry => currentEnquiry.Id == id, cancellationToken);

        if (enquiry is null)
        {
            return NotFound(new ErrorResponse("Enquiry was not found."));
        }

        if (!enquiry.Status.Equals("Pending", StringComparison.OrdinalIgnoreCase))
        {
            return BadRequest(new ErrorResponse("Only pending enquiries can be cancelled."));
        }

        if (request.SenderId.HasValue && request.SenderId.Value != enquiry.SenderId)
        {
            return Forbid();
        }

        enquiry.Status = "Cancelled";
        enquiry.CancelledAt = DateTimeOffset.UtcNow;
        enquiry.UpdatedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(EnquiryResponse.FromEnquiry(enquiry));
    }

    [HttpPost("{id}/agree-to-discuss")]
    public async Task<ActionResult<EnquiryResponse>> AgreeToDiscuss(
        int id,
        EnquiryDecisionRequest request,
        CancellationToken cancellationToken)
    {
        var enquiry = await dbContext.Enquiries
            .FirstOrDefaultAsync(currentEnquiry => currentEnquiry.Id == id, cancellationToken);

        if (enquiry is null)
        {
            return NotFound(new ErrorResponse("Enquiry was not found."));
        }

        var validationResult = ValidateReceiverDecision(enquiry, request);
        if (validationResult is not null)
        {
            return validationResult;
        }

        var now = DateTimeOffset.UtcNow;
        var ownerResponse = request.OwnerResponse;
        enquiry.Status = "Agreed";
        enquiry.OwnerResponse = HasText(ownerResponse)
            ? ownerResponse!.Trim()
            : "Agreed to discuss. Contact details are now available.";
        enquiry.AcceptedAt = now;
        enquiry.UpdatedAt = now;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(await BuildEnquiryResponse(enquiry, cancellationToken));
    }

    [HttpPost("{id}/decline")]
    public async Task<ActionResult<EnquiryResponse>> Decline(
        int id,
        EnquiryDecisionRequest request,
        CancellationToken cancellationToken)
    {
        var enquiry = await dbContext.Enquiries
            .FirstOrDefaultAsync(currentEnquiry => currentEnquiry.Id == id, cancellationToken);

        if (enquiry is null)
        {
            return NotFound(new ErrorResponse("Enquiry was not found."));
        }

        var validationResult = ValidateReceiverDecision(enquiry, request);
        if (validationResult is not null)
        {
            return validationResult;
        }

        var now = DateTimeOffset.UtcNow;
        var ownerResponse = request.OwnerResponse;
        enquiry.Status = "Declined";
        enquiry.OwnerResponse = HasText(ownerResponse)
            ? ownerResponse!.Trim()
            : "Declined by the listing owner.";
        enquiry.DeclinedAt = now;
        enquiry.UpdatedAt = now;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(await BuildEnquiryResponse(enquiry, cancellationToken));
    }

    private ActionResult? ValidateReceiverDecision(Enquiry enquiry, EnquiryDecisionRequest request)
    {
        if (request.ReceiverId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("Receiver user id is required."));
        }

        if (request.ReceiverId != enquiry.ReceiverId)
        {
            return Forbid();
        }

        if (!enquiry.Status.Equals("Pending", StringComparison.OrdinalIgnoreCase))
        {
            return BadRequest(new ErrorResponse("Only pending enquiries can be updated."));
        }

        return null;
    }

    private async Task<EnquiryResponse> BuildEnquiryResponse(Enquiry enquiry, CancellationToken cancellationToken)
    {
        var senderEmail = enquiry.SenderEmailSnapshot;
        var receiverEmail = await dbContext.Users
            .AsNoTracking()
            .Where(currentUser => currentUser.Id == enquiry.ReceiverId)
            .Select(currentUser => currentUser.Email)
            .FirstOrDefaultAsync(cancellationToken);

        return EnquiryResponse.FromEnquiry(enquiry, senderEmail, receiverEmail);
    }

    private static bool HasText(string? value)
    {
        return !string.IsNullOrWhiteSpace(value);
    }
}

public record SubmitEnquiryRequest(
    int ListingId,
    Guid SenderId,
    string SenderName,
    string Message,
    bool DisclaimerAccepted,
    string EnquiryType,
    int? OfferedListingId);

public record CancelEnquiryRequest(Guid? SenderId);

public record EnquiryDecisionRequest(Guid ReceiverId, string? OwnerResponse);

public record EnquiryStatusResponse(bool HasPendingEnquiry);

public record UserEnquiriesResponse(
    UserEnquiryItemResponse[] Sent,
    UserEnquiryItemResponse[] Received);

public record UserEnquiryItemResponse(
    int Id,
    int ListingId,
    int? OfferedListingId,
    ListingSummaryResponse? Listing,
    ListingSummaryResponse? OfferedListing,
    string CounterpartyName,
    string? CounterpartyEmail,
    string Status,
    string EnquiryType,
    string Message,
    string? OwnerResponse,
    DateOnly? DateSent,
    DateOnly? DateReceived)
{
    public static UserEnquiryItemResponse FromSentEnquiry(
        Enquiry enquiry,
        IReadOnlyDictionary<int, Listing> listingsById,
        IReadOnlyDictionary<Guid, User> usersById)
    {
        listingsById.TryGetValue(enquiry.ListingId, out var listing);
        Listing? offeredListing = null;
        if (enquiry.OfferedListingId.HasValue)
        {
            listingsById.TryGetValue(enquiry.OfferedListingId.Value, out offeredListing);
        }

        usersById.TryGetValue(enquiry.ReceiverId, out var receiver);
        var shouldShareContact = enquiry.Status.Equals("Agreed", StringComparison.OrdinalIgnoreCase);

        return new UserEnquiryItemResponse(
            enquiry.Id,
            enquiry.ListingId,
            enquiry.OfferedListingId,
            listing is null ? null : ListingSummaryResponse.FromListing(listing),
            offeredListing is null ? null : ListingSummaryResponse.FromListing(offeredListing),
            receiver?.Username ?? "Owner",
            shouldShareContact ? receiver?.Email : null,
            enquiry.Status,
            enquiry.EnquiryType,
            enquiry.Message,
            enquiry.OwnerResponse,
            enquiry.DateSent,
            enquiry.DateReceived);
    }

    public static UserEnquiryItemResponse FromReceivedEnquiry(
        Enquiry enquiry,
        IReadOnlyDictionary<int, Listing> listingsById,
        IReadOnlyDictionary<Guid, User> usersById)
    {
        listingsById.TryGetValue(enquiry.ListingId, out var listing);
        Listing? offeredListing = null;
        if (enquiry.OfferedListingId.HasValue)
        {
            listingsById.TryGetValue(enquiry.OfferedListingId.Value, out offeredListing);
        }

        usersById.TryGetValue(enquiry.SenderId, out var sender);
        var shouldShareContact = enquiry.Status.Equals("Agreed", StringComparison.OrdinalIgnoreCase);

        return new UserEnquiryItemResponse(
            enquiry.Id,
            enquiry.ListingId,
            enquiry.OfferedListingId,
            listing is null ? null : ListingSummaryResponse.FromListing(listing),
            offeredListing is null ? null : ListingSummaryResponse.FromListing(offeredListing),
            sender?.Username ?? "Sender",
            shouldShareContact ? sender?.Email ?? enquiry.SenderEmailSnapshot : null,
            enquiry.Status,
            enquiry.EnquiryType,
            enquiry.Message,
            enquiry.OwnerResponse,
            enquiry.DateSent,
            enquiry.DateReceived);
    }
}

public record ListingSummaryResponse(
    int ListingId,
    string Id,
    string Title,
    string Description,
    string Category,
    string ListingType,
    string Country,
    string City,
    string CurrentLocation,
    string ExchangeMethod,
    string[] ExchangeTimings,
    string[] ExchangeTypes,
    string[] WantedAssets,
    string[] WantedDestinations,
    DateOnly? AvailableFrom,
    DateOnly? AvailableTo,
    string? ImageLabel,
    DateOnly CreatedAt)
{
    public static ListingSummaryResponse FromListing(Listing listing)
    {
        return new ListingSummaryResponse(
            listing.Id,
            listing.Slug,
            listing.Title,
            listing.Description,
            listing.Category,
            listing.ListingType,
            listing.Country,
            listing.City,
            listing.CurrentLocation,
            listing.ExchangeMethod,
            listing.ExchangeTimings ?? [],
            listing.ExchangeTypes ?? [],
            listing.WantedAssets ?? [],
            listing.WantedDestinations ?? [],
            listing.AvailableFrom,
            listing.AvailableTo,
            listing.ImageLabel,
            DateOnly.FromDateTime(listing.CreatedAt.UtcDateTime));
    }
}

public record EnquiryResponse(
    int Id,
    int ListingId,
    int? OfferedListingId,
    string Status,
    string Message,
    string? SenderEmail,
    string? ReceiverEmail,
    string? OwnerResponse,
    DateOnly? DateSent)
{
    public static EnquiryResponse FromEnquiry(Enquiry enquiry, string? senderEmail = null, string? receiverEmail = null)
    {
        return new EnquiryResponse(
            enquiry.Id,
            enquiry.ListingId,
            enquiry.OfferedListingId,
            enquiry.Status,
            enquiry.Message,
            senderEmail ?? enquiry.SenderEmailSnapshot,
            receiverEmail,
            enquiry.OwnerResponse,
            enquiry.DateSent);
    }
}
