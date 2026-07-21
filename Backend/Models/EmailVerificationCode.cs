namespace MotorHome.Api.Models;

public class EmailVerificationCode
{
    public int Id { get; set; }

    public string Email { get; set; } = string.Empty;

    public string Purpose { get; set; } = "sign_up";

    public string CodeHash { get; set; } = string.Empty;

    public DateTimeOffset ExpiresAt { get; set; }

    public DateTimeOffset CreatedAt { get; set; }
        = DateTimeOffset.UtcNow;

    public DateTimeOffset? UsedAt { get; set; }
}
