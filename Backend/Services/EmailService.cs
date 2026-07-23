using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace MotorHome.Api.Services;

public class EmailService(
    HttpClient httpClient,
    IConfiguration configuration)
{
    public async Task SendEmailAsync(
        string recipient,
        string subject,
        string html,
        CancellationToken cancellationToken)
    {
        var apiKey = configuration["Email:ApiKey"];
        var from = configuration["Email:From"];

        if (string.IsNullOrWhiteSpace(apiKey))
        {
            throw new InvalidOperationException(
                "Email:ApiKey is not configured.");
        }

        if (string.IsNullOrWhiteSpace(from))
        {
            throw new InvalidOperationException(
                "Email:From is not configured.");
        }

        if (string.IsNullOrWhiteSpace(recipient))
        {
            throw new ArgumentException(
                "The recipient email address is required.",
                nameof(recipient));
        }

        using var request = new HttpRequestMessage(
            HttpMethod.Post,
            "https://api.resend.com/emails");

        request.Headers.Authorization =
            new AuthenticationHeaderValue("Bearer", apiKey);

        request.Content = JsonContent.Create(new
        {
            from,
            to = new[] { recipient },
            subject,
            html
        });

        using var response = await httpClient.SendAsync(
            request,
            cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            var error =
                await response.Content.ReadAsStringAsync(cancellationToken);

            throw new InvalidOperationException(
                $"Resend returned {(int)response.StatusCode}: {error}");
        }
    }
    public Task SendSignUpCodeAsync(
        string recipient,
        string code,
        CancellationToken cancellationToken)
    {
        var subject = "Your MT Exchange verification code";

        var html = $"""
            <h1>Verify your email address</h1>

            <p>Use the following code to complete your MT Exchange signup:</p>

            <p style="
                font-size: 28px;
                font-weight: bold;
                letter-spacing: 6px;">
                {System.Net.WebUtility.HtmlEncode(code)}
            </p>

            <p>This code expires in 10 minutes.</p>

            <p>
                If you did not request this code,
                you can safely ignore this email.
            </p>
            """;

        return SendEmailAsync(
            recipient,
            subject,
            html,
            cancellationToken);
    }

    public Task SendEnquiryNotificationAsync(
        string recipient,
        string receiverName,
        string senderName,
        string listingTitle,
        CancellationToken cancellationToken)
    {
        var appUrl = configuration["Email:AppUrl"];

        if (string.IsNullOrWhiteSpace(appUrl))
        {
            throw new InvalidOperationException(
                "Email:AppUrl is not configured.");
        }

        var userCenterUrl =
            $"{appUrl.TrimEnd('/')}/user-center";

        var safeReceiverName =
            System.Net.WebUtility.HtmlEncode(receiverName);

        var safeSenderName =
            System.Net.WebUtility.HtmlEncode(senderName);

        var safeListingTitle =
            System.Net.WebUtility.HtmlEncode(listingTitle);

        var safeUserCenterUrl =
            System.Net.WebUtility.HtmlEncode(userCenterUrl);

        var subjectListingTitle =
            listingTitle.ReplaceLineEndings(" ");

        var subject =
            $"New enquiry about {subjectListingTitle}";

        var html = $"""
            <h1>You received a new enquiry</h1>

            <p>Hi {safeReceiverName},</p>

            <p>
                {safeSenderName} sent you an enquiry about
                <strong>{safeListingTitle}</strong>.
            </p>

            <p>
                <a href="{safeUserCenterUrl}">
                    View the enquiry in your User Center
                </a>
            </p>

            <p>
                Sign in to review the enquiry and respond.
            </p>
            """;

        return SendEmailAsync(
            recipient,
            subject,
            html,
            cancellationToken);
    }
}
