using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Models;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProfileController(MotorHomeDbContext dbContext) : ControllerBase
{
    [HttpGet("{userId}")]
    public async Task<ActionResult<ProfileResponse>> GetProfile(
        Guid userId,
        CancellationToken cancellationToken)
    {
        if (userId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("User id is required."));
        }

        var user = await dbContext.Users
            .AsNoTracking()
            .FirstOrDefaultAsync(currentUser => currentUser.Id == userId, cancellationToken);

        if (user is null)
        {
            return NotFound(new ErrorResponse("User was not found."));
        }

        return Ok(ProfileResponse.FromUser(user));
    }

    [HttpPatch("{userId}/introduction")]
    public async Task<ActionResult<ProfileResponse>> UpdateIntroduction(
        Guid userId,
        UpdateIntroductionRequest request,
        CancellationToken cancellationToken)
    {
        if (userId == Guid.Empty)
        {
            return BadRequest(new ErrorResponse("User id is required."));
        }

        var user = await dbContext.Users
            .FirstOrDefaultAsync(currentUser => currentUser.Id == userId, cancellationToken);

        if (user is null)
        {
            return NotFound(new ErrorResponse("User was not found."));
        }

        user.Bio = string.IsNullOrWhiteSpace(request.Introduction)
            ? null
            : request.Introduction.Trim();
        user.UpdatedAt = DateTimeOffset.UtcNow;

        await dbContext.SaveChangesAsync(cancellationToken);

        return Ok(ProfileResponse.FromUser(user));
    }
}

public record UpdateIntroductionRequest(string? Introduction);

public record ProfileResponse(
    Guid Id,
    string UserName,
    string Email,
    string? Bio,
    string? Location,
    DateOnly? MemberSince,
    string? SpokenLanguages,
    bool IdentityVerified)
{
    public static ProfileResponse FromUser(User user)
    {
        return new ProfileResponse(
            user.Id,
            user.Username,
            user.Email,
            user.Bio,
            user.Location,
            user.MemberSince,
            user.SpokenLanguages,
            user.IdentityVerificationStatus.Equals("verified", StringComparison.OrdinalIgnoreCase));
    }
}
