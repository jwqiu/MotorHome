using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class VerificationController(MotorHomeDbContext dbContext) : ControllerBase
{
    [HttpPost("identity")]
    public async Task<ActionResult<VerificationResponse>> VerifyIdentity(
        IdentityVerificationRequest request,
        CancellationToken cancellationToken)
    {
        var email = NormalizeEmail(request.Email);
        if (
            !HasText(email) ||
            !HasText(request.LegalFirstName) ||
            !HasText(request.LegalLastName) ||
            request.DateOfBirth is null ||
            !HasText(request.LicenceNumber) ||
            !HasText(request.VersionNumber) ||
            !HasText(request.FrontLicenceFileName) ||
            !HasText(request.BackLicenceFileName) ||
            !request.ConfirmationAccepted)
        {
            return BadRequest(new ErrorResponse("All identity verification fields are required."));
        }

        var user = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Email.ToLower() == email, cancellationToken);

        if (user is null)
        {
            return NotFound(new ErrorResponse("No account was found for this email."));
        }

        user.IdentityVerificationStatus = "verified";
        user.IdentityDocumentType = "driver_licence";
        user.LegalFirstName = request.LegalFirstName.Trim();
        user.LegalLastName = request.LegalLastName.Trim();
        user.DateOfBirth = request.DateOfBirth;
        user.NzDriverLicenceNumber = request.LicenceNumber.Trim();
        user.DriverLicenceVersionNumber = request.VersionNumber.Trim();
        user.LicenceFrontFileUrl = request.FrontLicenceFileName.Trim();
        user.LicenceBackFileUrl = request.BackLicenceFileName.Trim();
        user.UpdatedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(new VerificationResponse(user.Id, user.Email, true));
    }

    private static string NormalizeEmail(string? email)
    {
        return email?.Trim().ToLowerInvariant() ?? string.Empty;
    }

    private static bool HasText(string? value)
    {
        return !string.IsNullOrWhiteSpace(value);
    }
}

public record IdentityVerificationRequest(
    string Email,
    string LegalFirstName,
    string LegalLastName,
    DateOnly? DateOfBirth,
    string LicenceNumber,
    string VersionNumber,
    string FrontLicenceFileName,
    string BackLicenceFileName,
    bool ConfirmationAccepted);

public record VerificationResponse(Guid Id, string Email, bool IdentityVerified);
