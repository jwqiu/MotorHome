namespace MotorHome.Api.Models;

public class Enquiry
{
    public int Id { get; set; }
    public int ListingId { get; set; }
    public Guid SenderId { get; set; }
    public Guid ReceiverId { get; set; }
    public int? OfferedListingId { get; set; }
    public string EnquiryType { get; set; } = "Direct Exchange";
    public string Status { get; set; } = "Pending";
    public string Message { get; set; } = string.Empty;
    public string? OwnerResponse { get; set; }
    public string? SenderEmailSnapshot { get; set; }
    public bool DisclaimerAccepted { get; set; }
    public DateOnly? DateSent { get; set; }
    public DateOnly? DateReceived { get; set; }
    public DateTimeOffset? AcceptedAt { get; set; }
    public DateTimeOffset? DeclinedAt { get; set; }
    public DateTimeOffset? CancelledAt { get; set; }
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;
}
