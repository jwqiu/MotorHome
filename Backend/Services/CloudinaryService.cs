using CloudinaryDotNet;
using CloudinaryDotNet.Actions;

namespace MotorHome.Api.Services;

public class CloudinaryService
{
    public Cloudinary Client { get; }

    public CloudinaryService(IConfiguration configuration)
    {
        var cloudName = configuration["Cloudinary:CloudName"];
        var apiKey = configuration["Cloudinary:ApiKey"];
        var apiSecret = configuration["Cloudinary:ApiSecret"];

        if (string.IsNullOrWhiteSpace(cloudName) ||
            string.IsNullOrWhiteSpace(apiKey) ||
            string.IsNullOrWhiteSpace(apiSecret))
        {
            throw new InvalidOperationException(
                "Cloudinary credentials have not been configured.");
        }

        var account = new Account(cloudName, apiKey, apiSecret);

        Client = new Cloudinary(account);
        Client.Api.Secure = true;
    }

    public async Task<CloudinaryImageResult> UploadImageAsync(
        IFormFile image,
        int listingId,
        CancellationToken cancellationToken)
    {
        await using var stream = image.OpenReadStream();

        var uploadParameters = new ImageUploadParams
        {
            File = new FileDescription(image.FileName, stream),
            Folder = $"motorhome/listings/{listingId}",

            Transformation = new Transformation()
                .Width(1800)
                .Height(1200)
                .Crop("limit")
                .Quality("auto"),

            UseFilename = false,
            UniqueFilename = true,
            Overwrite = false
        };

        var uploadResult = await Client.UploadAsync(
            uploadParameters,
            cancellationToken);

        if (uploadResult.Error is not null)
        {
            throw new InvalidOperationException(
                uploadResult.Error.Message);
        }

        var url = uploadResult.SecureUrl?.ToString();
        var publicId = uploadResult.PublicId;

        if (string.IsNullOrWhiteSpace(url) ||
            string.IsNullOrWhiteSpace(publicId))
        {
            throw new InvalidOperationException(
                "Cloudinary did not return the uploaded image details.");
        }

        return new CloudinaryImageResult(url, publicId);
    }

    public async Task DeleteImageAsync(string publicId)
    {
        var deletionParameters = new DeletionParams(publicId)
        {
            ResourceType = ResourceType.Image,
            Invalidate = true
        };

        var deletionResult = await Client.DestroyAsync(
            deletionParameters);

        if (deletionResult.Error is not null)
        {
            throw new InvalidOperationException(
                deletionResult.Error.Message);
        }
    }
}

public record CloudinaryImageResult(
    string Url,
    string PublicId);