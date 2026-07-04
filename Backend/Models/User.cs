namespace MotorHome.Api.Models;

public class User
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Username { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? PasswordHash { get; set; }
    public string? AvatarUrl { get; set; }
    public string? Bio { get; set; }
    public string? Location { get; set; }
    public DateOnly? MemberSince { get; set; }
    public string? SpokenLanguages { get; set; }
    public string IdentityVerificationStatus { get; set; } = "not_verified";
    public string? IdentityDocumentType { get; set; }
    public string? LegalFirstName { get; set; }
    public string? LegalLastName { get; set; }
    public DateOnly? DateOfBirth { get; set; }
    public string? NzDriverLicenceNumber { get; set; }
    public string? DriverLicenceVersionNumber { get; set; }
    public string? LicenceFrontFileUrl { get; set; }
    public string? LicenceBackFileUrl { get; set; }
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;
}
