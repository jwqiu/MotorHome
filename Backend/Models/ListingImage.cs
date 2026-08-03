namespace MotorHome.Api.Models;

public class ListingImage
{
    public int Id { get; set; }

    public int ListingId { get; set; }

    public string Url { get; set; } = string.Empty;

    public string PublicId { get; set; } = string.Empty;

    public int SortOrder { get; set; }

    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
}