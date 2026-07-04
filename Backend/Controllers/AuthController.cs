using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Models;
using MotorHome.Api.Services;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthController(MotorHomeDbContext dbContext, PasswordHashService passwordHashService) : ControllerBase
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

    [HttpPost("sign-up")]
    public async Task<ActionResult<AuthResponse>> SignUp(SignUpRequest request, CancellationToken cancellationToken)
    {
        var email = NormalizeEmail(request.Email);
        if (!HasText(request.UserName) || !HasText(email) || !HasText(request.Password) || !HasText(request.VerificationCode))
        {
            return BadRequest(new ErrorResponse("User name, email, password, and verification code are required."));
        }

        var emailAlreadyExists = await dbContext.Users
            .AnyAsync(currentUser => currentUser.Email.ToLower() == email, cancellationToken);

        if (emailAlreadyExists)
        {
            return Conflict(new ErrorResponse("An account with this email already exists."));
        }

        var now = DateTimeOffset.UtcNow;
        var user = new User
        {
            Username = request.UserName.Trim(),
            Email = email,
            PasswordHash = passwordHashService.HashPassword(request.Password),
            CreatedAt = now,
            UpdatedAt = now
        };

        dbContext.Users.Add(user);
        await dbContext.SaveChangesAsync(cancellationToken);

        return Created($"/api/users/{user.Id}", AuthResponse.FromUser(user));
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
