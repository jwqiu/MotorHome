namespace MotorHome.Api.Models;

public class Listing
{
    public int Id { get; set; }
    public string Slug { get; set; } = string.Empty;
    public Guid OwnerId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string ListingType { get; set; } = string.Empty;
    public string Country { get; set; } = string.Empty;
    public string City { get; set; } = string.Empty;
    public string CurrentLocation { get; set; } = string.Empty;
    public string ExchangeMethod { get; set; } = "Direct Exchange";
    public string[] ExchangeTimings { get; set; } = [];
    public string[] ExchangeTypes { get; set; } = [];
    public string[] WantedAssets { get; set; } = [];
    public string[] WantedDestinations { get; set; } = [];
    public DateOnly? AvailableFrom { get; set; }
    public DateOnly? AvailableTo { get; set; }
    public string? ImageLabel { get; set; }
    public string? ImageAssetKey { get; set; }
    public string Status { get; set; } = "active";
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;
}
