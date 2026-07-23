using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Services;

var builder = WebApplication.CreateBuilder(args);
const string FrontendCorsPolicy = "FrontendCorsPolicy";

builder.Services.AddDbContext<MotorHomeDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("MotorHome")));
builder.Services.AddScoped<PasswordHashService>();

builder.Services.AddHttpClient<EmailService>(client =>
{
    client.DefaultRequestHeaders.UserAgent.ParseAdd("MotorHome.Api/1.0");
    client.Timeout = TimeSpan.FromSeconds(10);
});

builder.Services.AddCors(options =>
{
    options.AddPolicy(FrontendCorsPolicy, policy =>
    {
        var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>() ?? [];

        policy
            .WithOrigins(allowedOrigins)
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors(FrontendCorsPolicy);

app.UseAuthorization();

app.MapControllers();

app.Run();
