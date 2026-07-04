using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Models;
using System.Text.RegularExpressions;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ListingController(MotorHomeDbContext dbContext) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<ListingDetailResponse[]>> GetListings(
        [FromQuery] string? country,
        [FromQuery] string? city,
        [FromQuery] string? category,
        [FromQuery] string? listingType,
        [FromQuery] string? exchangeMethod,
        [FromQuery] string[] exchangeTimings,
        [FromQuery] DateOnly? availableFrom,
        [FromQuery] DateOnly? availableTo,
        CancellationToken cancellationToken)
    {
        var query = dbContext.Listings
            .AsNoTracking()
            .Where(currentListing => currentListing.Status == "active");

        if (!string.IsNullOrWhiteSpace(country))
        {
            var requestedCountry = country.Trim();
            query = query.Where(currentListing => currentListing.Country == requestedCountry);
        }

        if (!string.IsNullOrWhiteSpace(city))
        {
            var requestedCity = city.Trim();
            query = query.Where(currentListing => currentListing.City == requestedCity);
        }

        if (!string.IsNullOrWhiteSpace(category))
        {
            var requestedCategory = category.Trim();
            query = query.Where(currentListing => currentListing.Category == requestedCategory);
        }

        if (!string.IsNullOrWhiteSpace(listingType))
        {
            var requestedListingType = listingType.Trim();
            query = query.Where(currentListing => currentListing.ListingType == requestedListingType);
        }

        if (!string.IsNullOrWhiteSpace(exchangeMethod))
        {
            var requestedExchangeMethod = NormalizeExchangeMethod(exchangeMethod);
            query = query.Where(currentListing => currentListing.ExchangeMethod == requestedExchangeMethod);
        }

        if (availableFrom.HasValue)
        {
            query = query.Where(currentListing => !currentListing.AvailableTo.HasValue ||
                currentListing.AvailableTo.Value >= availableFrom.Value);
        }

        if (availableTo.HasValue)
        {
            query = query.Where(currentListing => !currentListing.AvailableFrom.HasValue ||
                currentListing.AvailableFrom.Value <= availableTo.Value);
        }

        var listings = await query
            .OrderByDescending(currentListing => currentListing.CreatedAt)
            .ToListAsync(cancellationToken);

        var requestedExchangeTimings = exchangeTimings
            .Where(currentTiming => !string.IsNullOrWhiteSpace(currentTiming))
            .Select(currentTiming => currentTiming.Trim())
            .ToArray();

        if (requestedExchangeTimings.Length > 0)
        {
            listings = listings
                .Where(currentListing => requestedExchangeTimings
                    .Any(currentTiming => currentListing.ExchangeTimings.Contains(currentTiming)))
                .ToList();
        }

        var ownerIds = listings
            .Select(currentListing => currentListing.OwnerId)
            .Distinct()
            .ToArray();

        var owners = await dbContext.Users
            .AsNoTracking()
            .Where(currentUser => ownerIds.Contains(currentUser.Id))
            .ToDictionaryAsync(currentUser => currentUser.Id, cancellationToken);

        var response = listings
            .Where(currentListing => owners.ContainsKey(currentListing.OwnerId))
            .Select(currentListing => ListingDetailResponse.FromListing(currentListing, owners[currentListing.OwnerId]))
            .ToArray();

        return Ok(response);
    }

    [HttpPost]
    public async Task<ActionResult<ListingDetailResponse>> CreateListing(
        SaveListingRequest request,
        CancellationToken cancellationToken)
    {
        var validationError = ValidateListingRequest(request);
        if (validationError is not null)
        {
            return BadRequest(new ErrorResponse(validationError));
        }

        var owner = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Id == request.OwnerId, cancellationToken);

        if (owner is null)
        {
            return NotFound(new ErrorResponse("Owner account was not found."));
        }

        var now = DateTimeOffset.UtcNow;
        var listing = new Listing
        {
            OwnerId = owner.Id,
            Slug = await BuildUniqueSlug(request.Title, null, cancellationToken),
            Title = request.Title.Trim(),
            Description = request.Description.Trim(),
            Category = request.Category.Trim(),
            ListingType = request.ListingType.Trim(),
            Country = request.Country.Trim(),
            City = request.City.Trim(),
            CurrentLocation = request.CurrentLocation.Trim(),
            ExchangeMethod = NormalizeExchangeMethod(request.ExchangeMethod),
            ExchangeTimings = CleanStringArray(request.ExchangeTimings),
            ExchangeTypes = CleanStringArray(request.ExchangeTimings),
            WantedAssets = CleanStringArray(request.WantedAssets),
            WantedDestinations = CleanStringArray(request.WantedDestinations),
            AvailableFrom = request.AvailableFrom,
            AvailableTo = request.AvailableTo,
            ImageLabel = HasText(request.ImageLabel) ? request.ImageLabel!.Trim() : request.Title.Trim(),
            ImageAssetKey = request.ImageAssetKey,
            Status = "active",
            CreatedAt = now,
            UpdatedAt = now
        };

        dbContext.Listings.Add(listing);
        await dbContext.SaveChangesAsync(cancellationToken);

        return Created($"/api/listing/{listing.Slug}", ListingDetailResponse.FromListing(listing, owner));
    }

    [HttpPut("{id:int}")]
    public async Task<ActionResult<ListingDetailResponse>> UpdateListing(
        int id,
        SaveListingRequest request,
        CancellationToken cancellationToken)
    {
        if (id <= 0)
        {
            return BadRequest(new ErrorResponse("Listing id is required."));
        }

        var validationError = ValidateListingRequest(request);
        if (validationError is not null)
        {
            return BadRequest(new ErrorResponse(validationError));
        }

        var listing = await dbContext.Listings
            .FirstOrDefaultAsync(currentListing => currentListing.Id == id, cancellationToken);

        if (listing is null)
        {
            return NotFound(new ErrorResponse("Listing was not found."));
        }

        if (listing.OwnerId != request.OwnerId)
        {
            return Forbid();
        }

        var owner = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Id == request.OwnerId, cancellationToken);

        if (owner is null)
        {
            return NotFound(new ErrorResponse("Owner account was not found."));
        }

        listing.Slug = await BuildUniqueSlug(request.Title, listing.Id, cancellationToken);
        listing.Title = request.Title.Trim();
        listing.Description = request.Description.Trim();
        listing.Category = request.Category.Trim();
        listing.ListingType = request.ListingType.Trim();
        listing.Country = request.Country.Trim();
        listing.City = request.City.Trim();
        listing.CurrentLocation = request.CurrentLocation.Trim();
        listing.ExchangeMethod = NormalizeExchangeMethod(request.ExchangeMethod);
        listing.ExchangeTimings = CleanStringArray(request.ExchangeTimings);
        listing.ExchangeTypes = CleanStringArray(request.ExchangeTimings);
        listing.WantedAssets = CleanStringArray(request.WantedAssets);
        listing.WantedDestinations = CleanStringArray(request.WantedDestinations);
        listing.AvailableFrom = request.AvailableFrom;
        listing.AvailableTo = request.AvailableTo;
        listing.ImageLabel = HasText(request.ImageLabel) ? request.ImageLabel!.Trim() : request.Title.Trim();
        listing.ImageAssetKey = request.ImageAssetKey;
        listing.UpdatedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(ListingDetailResponse.FromListing(listing, owner));
    }

    [HttpDelete("{id:int}")]
    public async Task<ActionResult<DeleteListingResponse>> DeleteListing(
        int id,
        [FromQuery] Guid ownerId,
        CancellationToken cancellationToken)
    {
        if (id <= 0 || ownerId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("Listing id and owner user id are required."));
        }

        var listing = await dbContext.Listings
            .FirstOrDefaultAsync(currentListing => currentListing.Id == id, cancellationToken);

        if (listing is null)
        {
            return NotFound(new ErrorResponse("Listing was not found."));
        }

        if (listing.OwnerId != ownerId)
        {
            return Forbid();
        }

        var relatedEnquiries = await dbContext.Enquiries
            .Where(currentEnquiry => currentEnquiry.ListingId == listing.Id ||
                currentEnquiry.OfferedListingId == listing.Id)
            .ToListAsync(cancellationToken);

        var hasActiveEnquiries = relatedEnquiries.Any(currentEnquiry =>
            currentEnquiry.Status.Equals("Pending", StringComparison.OrdinalIgnoreCase));

        if (hasActiveEnquiries)
        {
            return Conflict(new ErrorResponse(
                "This listing is linked to active exchange enquiries. Please complete, decline, or cancel the related enquiries before deleting it."));
        }

        dbContext.Enquiries.RemoveRange(relatedEnquiries);
        dbContext.Listings.Remove(listing);
        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(new DeleteListingResponse(listing.Id, relatedEnquiries.Count));
    }

    [HttpGet("owner/{ownerId}")]
    public async Task<ActionResult<ListingDetailResponse[]>> GetListingsByOwner(
        Guid ownerId,
        CancellationToken cancellationToken)
    {
        if (ownerId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("Owner user id is required."));
        }

        var owner = await dbContext.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(currentUser => currentUser.Id == ownerId, cancellationToken);

        if (owner is null)
        {
            return NotFound(new ErrorResponse("Owner was not found."));
        }

        var listings = await dbContext.Listings
            .AsNoTracking()
            .Where(currentListing => currentListing.OwnerId == ownerId)
            .OrderBy(currentListing => currentListing.Id)
            .Select(currentListing => ListingDetailResponse.FromListing(currentListing, owner))
            .ToArrayAsync(cancellationToken);

        return Ok(listings);
    }

    [HttpGet("{slug}")]
    public async Task<ActionResult<ListingDetailResponse>> GetListingDetail(
        string slug,
        CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(slug))
        {
            return BadRequest(new ErrorResponse("Listing slug is required."));
        }

        var listing = await dbContext.Listings
            .AsNoTracking()
            .FirstOrDefaultAsync(currentListing => currentListing.Slug == slug.Trim(), cancellationToken);

        if (listing is null)
        {
            return NotFound(new ErrorResponse("Listing was not found."));
        }

        var owner = await dbContext.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(currentUser => currentUser.Id == listing.OwnerId, cancellationToken);

        if (owner is null)
        {
            return NotFound(new ErrorResponse("Listing owner was not found."));
        }

        return Ok(ListingDetailResponse.FromListing(listing, owner));
    }

    private static string NormalizeExchangeMethod(string exchangeMethod)
    {
        var trimmedExchangeMethod = exchangeMethod.Trim();

        return trimmedExchangeMethod == "Use Points"
            ? "Point Exchange"
            : trimmedExchangeMethod;
    }

    private async Task<string> BuildUniqueSlug(
        string title,
        int? existingListingId,
        CancellationToken cancellationToken)
    {
        var baseSlug = Regex.Replace(title.Trim().ToLowerInvariant(), "[^a-z0-9]+", "-").Trim('-');
        if (!HasText(baseSlug))
        {
            baseSlug = "listing";
        }

        var slug = baseSlug;
        var suffix = 2;

        while (await dbContext.Listings.AnyAsync(currentListing =>
            currentListing.Slug == slug &&
            (!existingListingId.HasValue || currentListing.Id != existingListingId.Value),
            cancellationToken))
        {
            slug = $"{baseSlug}-{suffix}";
            suffix++;
        }

        return slug;
    }

    private static string? ValidateListingRequest(SaveListingRequest request)
    {
        if (
            request.OwnerId == Guid.Empty ||
            !HasText(request.Title) ||
            !HasText(request.Description) ||
            !HasText(request.Category) ||
            !HasText(request.ListingType) ||
            !HasText(request.Country) ||
            !HasText(request.City) ||
            !HasText(request.CurrentLocation) ||
            !HasText(request.ExchangeMethod) ||
            request.ExchangeTimings.Length == 0 ||
            request.WantedAssets.Length == 0 ||
            request.WantedDestinations.Length == 0)
        {
            return "Owner, title, description, category, listing type, location, exchange method, exchange timing, wanted assets, and wanted destinations are required.";
        }

        if (request.AvailableFrom.HasValue &&
            request.AvailableTo.HasValue &&
            request.AvailableFrom.Value > request.AvailableTo.Value)
        {
            return "Available from date cannot be later than available to date.";
        }

        return null;
    }

    private static string[] CleanStringArray(string[] values)
    {
        return values
            .Where(HasText)
            .Select(currentValue => currentValue.Trim())
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToArray();
    }

    private static bool HasText(string? value)
    {
        return !string.IsNullOrWhiteSpace(value);
    }
}

public record SaveListingRequest(
    Guid OwnerId,
    string Title,
    string Description,
    string Category,
    string ListingType,
    string Country,
    string City,
    string CurrentLocation,
    string ExchangeMethod,
    string[] ExchangeTimings,
    string[] WantedAssets,
    string[] WantedDestinations,
    DateOnly? AvailableFrom,
    DateOnly? AvailableTo,
    string? ImageLabel,
    string? ImageAssetKey);

public record DeleteListingResponse(int ListingId, int DeletedEnquiries);

public record ListingDetailResponse(
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
    string? ImageAssetKey,
    DateOnly CreatedAt,
    ListingOwnerResponse Owner)
{
    public static ListingDetailResponse FromListing(Listing listing, User owner)
    {
        return new ListingDetailResponse(
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
            listing.ExchangeTimings,
            listing.ExchangeTypes,
            listing.WantedAssets,
            listing.WantedDestinations,
            listing.AvailableFrom,
            listing.AvailableTo,
            listing.ImageLabel,
            listing.ImageAssetKey,
            DateOnly.FromDateTime(listing.CreatedAt.UtcDateTime),
            ListingOwnerResponse.FromUser(owner));
    }
}

public record ListingOwnerResponse(
    Guid Id,
    string DisplayName,
    string Location,
    string MemberSince,
    string SpokenLanguages,
    string About)
{
    public static ListingOwnerResponse FromUser(User user)
    {
        return new ListingOwnerResponse(
            user.Id,
            user.Username,
            user.Location ?? string.Empty,
            user.MemberSince?.ToString("dd/MM/yyyy") ?? string.Empty,
            user.SpokenLanguages ?? string.Empty,
            user.Bio ?? string.Empty);
    }
}
