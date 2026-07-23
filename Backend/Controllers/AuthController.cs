using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Models;
using MotorHome.Api.Services;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController(
    MotorHomeDbContext dbContext,
    PasswordHashService passwordHashService,
    EmailService emailService,
    IConfiguration configuration) : ControllerBase
{
    [HttpPost("login")]
    public async Task<ActionResult<AuthResponse>> Login(LoginRequest request, CancellationToken cancellationToken)
    {
        var email = NormalizeEmail(request.Email);
        var user = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Email.ToLower() == email, cancellationToken);

        if (user is null || !passwordHashService.VerifyPassword(request.Password, user.PasswordHash))
        {
            return Unauthorized(new ErrorResponse("Invalid email or password."));
        }

        return Ok(AuthResponse.FromUser(user));
    }

    [HttpPost("sign-up/code")]
    public async Task<ActionResult> SendSignUpCode(
        SendSignUpCodeRequest request,
        CancellationToken cancellationToken)
    {
        const string purpose = "sign_up";

        var email = NormalizeEmail(request.Email);

        if (
            !HasText(email) ||
            !MailAddress.TryCreate(email, out _))
        {
            return BadRequest(
                new ErrorResponse("A valid email address is required."));
        }

        var accountExists = await dbContext.Users.AnyAsync(
            currentUser => currentUser.Email.ToLower() == email,
            cancellationToken);

        if (accountExists)
        {
            return Conflict(
                new ErrorResponse(
                    "An account with this email already exists."));
        }

        var now = DateTimeOffset.UtcNow;

        var existingCode =
            await dbContext.EmailVerificationCodes.FirstOrDefaultAsync(
                currentCode =>
                    currentCode.Email == email &&
                    currentCode.Purpose == purpose,
                cancellationToken);

        if (
            existingCode is not null &&
            existingCode.CreatedAt > now.AddMinutes(-1))
        {
            return StatusCode(
                StatusCodes.Status429TooManyRequests,
                new ErrorResponse(
                    "Please wait one minute before requesting another code."));
        }

        var hmacKey = configuration["Verification:HmacKey"];

        if (string.IsNullOrWhiteSpace(hmacKey))
        {
            throw new InvalidOperationException(
                "Verification:HmacKey is not configured.");
        }

        var code = RandomNumberGenerator
            .GetInt32(100_000, 1_000_000)
            .ToString();

        var codeHash = CalculateCodeHash(code, hmacKey);

        await emailService.SendSignUpCodeAsync(
            email,
            code,
            cancellationToken);

        if (existingCode is null)
        {
            existingCode = new EmailVerificationCode
            {
                Email = email,
                Purpose = purpose
            };

            dbContext.EmailVerificationCodes.Add(existingCode);
        }

        existingCode.CodeHash = codeHash;
        existingCode.CreatedAt = now;
        existingCode.ExpiresAt = now.AddMinutes(10);
        existingCode.UsedAt = null;

        await dbContext.SaveChangesAsync(cancellationToken);

        return NoContent();
    }

    [HttpPost("sign-up/code/verify")]
    public async Task<ActionResult> VerifySignUpCode(
        VerifySignUpCodeRequest request,
        CancellationToken cancellationToken)
    {
        const string purpose = "sign_up";

        var email = NormalizeEmail(request.Email);

        if (
            !HasText(email) ||
            !HasText(request.VerificationCode) ||
            request.VerificationCode.Length != 6 ||
            !request.VerificationCode.All(char.IsDigit))
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code must contain six digits."));
        }

        var now = DateTimeOffset.UtcNow;

        var storedCode =
            await dbContext.EmailVerificationCodes.FirstOrDefaultAsync(
                currentCode =>
                    currentCode.Email == email &&
                    currentCode.Purpose == purpose,
                cancellationToken);

        if (
            storedCode is null ||
            storedCode.UsedAt is not null ||
            storedCode.ExpiresAt <= now)
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code is invalid or has expired."));
        }

        var hmacKey = configuration["Verification:HmacKey"];

        if (string.IsNullOrWhiteSpace(hmacKey))
        {
            throw new InvalidOperationException(
                "Verification:HmacKey is not configured.");
        }

        var submittedHash = CalculateCodeHash(
            request.VerificationCode,
            hmacKey);

        var codeMatches = CryptographicOperations.FixedTimeEquals(
            Convert.FromHexString(storedCode.CodeHash),
            Convert.FromHexString(submittedHash));

        if (!codeMatches)
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code is invalid or has expired."));
        }

        return NoContent();
    }

    [HttpPost("sign-up")]
    public async Task<ActionResult<AuthResponse>> SignUp(
        SignUpRequest request,
        CancellationToken cancellationToken)
    {
        const string purpose = "sign_up";

        var email = NormalizeEmail(request.Email);

        if (
            !HasText(request.UserName) ||
            !HasText(email) ||
            !HasText(request.Password) ||
            !HasText(request.VerificationCode))
        {
            return BadRequest(
                new ErrorResponse(
                    "User name, email, password, and verification code are required."));
        }

        if (
            request.VerificationCode.Length != 6 ||
            !request.VerificationCode.All(char.IsDigit))
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code must contain six digits."));
        }

        var emailAlreadyExists = await dbContext.Users.AnyAsync(
            currentUser => currentUser.Email.ToLower() == email,
            cancellationToken);

        if (emailAlreadyExists)
        {
            return Conflict(
                new ErrorResponse(
                    "An account with this email already exists."));
        }

        var now = DateTimeOffset.UtcNow;

        var storedCode =
            await dbContext.EmailVerificationCodes.FirstOrDefaultAsync(
                currentCode =>
                    currentCode.Email == email &&
                    currentCode.Purpose == purpose,
                cancellationToken);

        if (
            storedCode is null ||
            storedCode.UsedAt is not null ||
            storedCode.ExpiresAt <= now)
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code is invalid or has expired."));
        }

        var hmacKey = configuration["Verification:HmacKey"];

        if (string.IsNullOrWhiteSpace(hmacKey))
        {
            throw new InvalidOperationException(
                "Verification:HmacKey is not configured.");
        }

        var submittedHash = CalculateCodeHash(
            request.VerificationCode,
            hmacKey);

        var codeMatches = CryptographicOperations.FixedTimeEquals(
            Convert.FromHexString(storedCode.CodeHash),
            Convert.FromHexString(submittedHash));

        if (!codeMatches)
        {
            return BadRequest(
                new ErrorResponse(
                    "The verification code is invalid or has expired."));
        }

        var user = new User
        {
            Username = request.UserName.Trim(),
            Email = email,
            PasswordHash =
                passwordHashService.HashPassword(request.Password),
            CreatedAt = now,
            UpdatedAt = now
        };

        storedCode.UsedAt = now;

        dbContext.Users.Add(user);

        await dbContext.SaveChangesAsync(cancellationToken);

        return Created(
            $"/api/users/{user.Id}",
            AuthResponse.FromUser(user));
    }

    [HttpPost("forgot-password")]
    public async Task<ActionResult<AuthResponse>> ForgotPassword(ForgotPasswordRequest request, CancellationToken cancellationToken)
    {
        var email = NormalizeEmail(request.Email);
        if (!HasText(email) || !HasText(request.NewPassword) || !HasText(request.VerificationCode))
        {
            return BadRequest(new ErrorResponse("Email, new password, and verification code are required."));
        }

        var user = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Email.ToLower() == email, cancellationToken);

        if (user is null)
        {
            return NotFound(new ErrorResponse("No account was found for this email."));
        }

        user.PasswordHash = passwordHashService.HashPassword(request.NewPassword);
        user.UpdatedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(AuthResponse.FromUser(user));
    }

    private static string CalculateCodeHash(string code, string hmacKey)
    {
        var keyBytes = Convert.FromBase64String(hmacKey);
        var codeBytes = Encoding.UTF8.GetBytes(code);

        using var hmac = new HMACSHA256(keyBytes);

        return Convert.ToHexString(
            hmac.ComputeHash(codeBytes));
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

public record LoginRequest(string Email, string Password);

public record SignUpRequest(string UserName, string Email, string Password, string VerificationCode);

public record ForgotPasswordRequest(string Email, string NewPassword, string VerificationCode);

public record ErrorResponse(string Message);

public record SendSignUpCodeRequest(string Email);

public record VerifySignUpCodeRequest(string Email, string VerificationCode);

public record AuthResponse(Guid Id, string UserName, string Email, bool IdentityVerified)
{
    public static AuthResponse FromUser(User user)
    {
        return new AuthResponse(
            user.Id,
            user.Username,
            user.Email,
            user.IdentityVerificationStatus.Equals("verified", StringComparison.OrdinalIgnoreCase));
    }
}
