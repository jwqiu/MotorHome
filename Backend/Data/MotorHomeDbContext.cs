using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Models;

namespace MotorHome.Api.Data;

public class MotorHomeDbContext(DbContextOptions<MotorHomeDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Listing> Listings => Set<Listing>();
    public DbSet<Enquiry> Enquiries => Set<Enquiry>();
    public DbSet<EmailVerificationCode> EmailVerificationCodes => Set<EmailVerificationCode>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var user = modelBuilder.Entity<User>();

        user.ToTable("users");
        user.HasKey(currentUser => currentUser.Id);
        user.HasIndex(currentUser => currentUser.Email).IsUnique();

        user.Property(currentUser => currentUser.Id).HasColumnName("id");
        user.Property(currentUser => currentUser.Username).HasColumnName("username");
        user.Property(currentUser => currentUser.Email).HasColumnName("email");
        user.Property(currentUser => currentUser.PasswordHash).HasColumnName("password_hash");
        user.Property(currentUser => currentUser.AvatarUrl).HasColumnName("avatar_url");
        user.Property(currentUser => currentUser.Bio).HasColumnName("bio");
        user.Property(currentUser => currentUser.Location).HasColumnName("location");
        user.Property(currentUser => currentUser.MemberSince).HasColumnName("member_since");
        user.Property(currentUser => currentUser.SpokenLanguages).HasColumnName("spoken_languages");
        user.Property(currentUser => currentUser.IdentityVerificationStatus).HasColumnName("identity_verification_status");
        user.Property(currentUser => currentUser.IdentityDocumentType).HasColumnName("identity_document_type");
        user.Property(currentUser => currentUser.LegalFirstName).HasColumnName("legal_first_name");
        user.Property(currentUser => currentUser.LegalLastName).HasColumnName("legal_last_name");
        user.Property(currentUser => currentUser.DateOfBirth).HasColumnName("date_of_birth");
        user.Property(currentUser => currentUser.NzDriverLicenceNumber).HasColumnName("nz_driver_licence_number");
        user.Property(currentUser => currentUser.DriverLicenceVersionNumber).HasColumnName("driver_licence_version_number");
        user.Property(currentUser => currentUser.LicenceFrontFileUrl).HasColumnName("licence_front_file_url");
        user.Property(currentUser => currentUser.LicenceBackFileUrl).HasColumnName("licence_back_file_url");
        user.Property(currentUser => currentUser.CreatedAt).HasColumnName("created_at");
        user.Property(currentUser => currentUser.UpdatedAt).HasColumnName("updated_at");

        var listing = modelBuilder.Entity<Listing>();

        listing.ToTable("listings");
        listing.HasKey(currentListing => currentListing.Id);
        listing.HasIndex(currentListing => currentListing.Slug).IsUnique();
        listing.HasOne<User>()
            .WithMany()
            .HasForeignKey(currentListing => currentListing.OwnerId)
            .OnDelete(DeleteBehavior.Restrict);
        listing.Property(currentListing => currentListing.Id).HasColumnName("id");
        listing.Property(currentListing => currentListing.Slug).HasColumnName("slug");
        listing.Property(currentListing => currentListing.OwnerId).HasColumnName("owner_id").IsRequired();
        listing.Property(currentListing => currentListing.Title).HasColumnName("title");
        listing.Property(currentListing => currentListing.Description).HasColumnName("description");
        listing.Property(currentListing => currentListing.Category).HasColumnName("category");
        listing.Property(currentListing => currentListing.ListingType).HasColumnName("listing_type");
        listing.Property(currentListing => currentListing.Country).HasColumnName("country");
        listing.Property(currentListing => currentListing.City).HasColumnName("city");
        listing.Property(currentListing => currentListing.CurrentLocation).HasColumnName("current_location");
        listing.Property(currentListing => currentListing.ExchangeMethod).HasColumnName("exchange_method");
        listing.Property(currentListing => currentListing.ExchangeTimings).HasColumnName("exchange_timings");
        listing.Property(currentListing => currentListing.ExchangeTypes).HasColumnName("exchange_types");
        listing.Property(currentListing => currentListing.WantedAssets).HasColumnName("wanted_assets");
        listing.Property(currentListing => currentListing.WantedDestinations).HasColumnName("wanted_destinations");
        listing.Property(currentListing => currentListing.AvailableFrom).HasColumnName("available_from");
        listing.Property(currentListing => currentListing.AvailableTo).HasColumnName("available_to");
        listing.Property(currentListing => currentListing.ImageLabel).HasColumnName("image_label");
        listing.Property(currentListing => currentListing.ImageAssetKey).HasColumnName("image_asset_key");
        listing.Property(currentListing => currentListing.Status).HasColumnName("status");
        listing.Property(currentListing => currentListing.CreatedAt).HasColumnName("created_at");
        listing.Property(currentListing => currentListing.UpdatedAt).HasColumnName("updated_at");

        var enquiry = modelBuilder.Entity<Enquiry>();

        enquiry.ToTable("enquiries");
        enquiry.HasKey(currentEnquiry => currentEnquiry.Id);
        enquiry.HasIndex(currentEnquiry => currentEnquiry.SenderId);
        enquiry.HasIndex(currentEnquiry => currentEnquiry.ReceiverId);
        enquiry.HasIndex(currentEnquiry => currentEnquiry.ListingId);
        enquiry.HasIndex(currentEnquiry => currentEnquiry.Status);
        enquiry.HasOne<Listing>()
            .WithMany()
            .HasForeignKey(currentEnquiry => currentEnquiry.ListingId)
            .OnDelete(DeleteBehavior.Restrict);
        enquiry.HasOne<User>()
            .WithMany()
            .HasForeignKey(currentEnquiry => currentEnquiry.SenderId)
            .OnDelete(DeleteBehavior.Restrict);
        enquiry.HasOne<User>()
            .WithMany()
            .HasForeignKey(currentEnquiry => currentEnquiry.ReceiverId)
            .OnDelete(DeleteBehavior.Restrict);
        enquiry.HasOne<Listing>()
            .WithMany()
            .HasForeignKey(currentEnquiry => currentEnquiry.OfferedListingId)
            .OnDelete(DeleteBehavior.Restrict);
        enquiry.Property(currentEnquiry => currentEnquiry.Id).HasColumnName("id");
        enquiry.Property(currentEnquiry => currentEnquiry.ListingId).HasColumnName("listing_id");
        enquiry.Property(currentEnquiry => currentEnquiry.SenderId).HasColumnName("sender_id").IsRequired();
        enquiry.Property(currentEnquiry => currentEnquiry.ReceiverId).HasColumnName("receiver_id").IsRequired();
        enquiry.Property(currentEnquiry => currentEnquiry.OfferedListingId).HasColumnName("offered_listing_id");
        enquiry.Property(currentEnquiry => currentEnquiry.EnquiryType).HasColumnName("enquiry_type");
        enquiry.Property(currentEnquiry => currentEnquiry.Status).HasColumnName("status");
        enquiry.Property(currentEnquiry => currentEnquiry.Message).HasColumnName("message");
        enquiry.Property(currentEnquiry => currentEnquiry.OwnerResponse).HasColumnName("owner_response");
        enquiry.Property(currentEnquiry => currentEnquiry.SenderEmailSnapshot).HasColumnName("sender_email_snapshot");
        enquiry.Property(currentEnquiry => currentEnquiry.DisclaimerAccepted).HasColumnName("disclaimer_accepted");
        enquiry.Property(currentEnquiry => currentEnquiry.DateSent).HasColumnName("date_sent");
        enquiry.Property(currentEnquiry => currentEnquiry.DateReceived).HasColumnName("date_received");
        enquiry.Property(currentEnquiry => currentEnquiry.AcceptedAt).HasColumnName("accepted_at");
        enquiry.Property(currentEnquiry => currentEnquiry.DeclinedAt).HasColumnName("declined_at");
        enquiry.Property(currentEnquiry => currentEnquiry.CancelledAt).HasColumnName("cancelled_at");
        enquiry.Property(currentEnquiry => currentEnquiry.CreatedAt).HasColumnName("created_at");
        enquiry.Property(currentEnquiry => currentEnquiry.UpdatedAt).HasColumnName("updated_at");

        var emailVerificationCode = modelBuilder.Entity<EmailVerificationCode>();

        emailVerificationCode.ToTable("email_verification_codes");

        emailVerificationCode.HasKey(currentCode => currentCode.Id);

        emailVerificationCode
            .HasIndex(currentCode => new
            {
                currentCode.Email,
                currentCode.Purpose
            })
            .IsUnique();

        emailVerificationCode
            .Property(currentCode => currentCode.Id)
            .HasColumnName("id");

        emailVerificationCode
            .Property(currentCode => currentCode.Email)
            .HasColumnName("email");

        emailVerificationCode
            .Property(currentCode => currentCode.Purpose)
            .HasColumnName("purpose");

        emailVerificationCode
            .Property(currentCode => currentCode.CodeHash)
            .HasColumnName("code_hash");

        emailVerificationCode
            .Property(currentCode => currentCode.ExpiresAt)
            .HasColumnName("expires_at");

        emailVerificationCode
            .Property(currentCode => currentCode.CreatedAt)
            .HasColumnName("created_at");

        emailVerificationCode
            .Property(currentCode => currentCode.UsedAt)
            .HasColumnName("used_at");
    }
}
