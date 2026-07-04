using Microsoft.EntityFrameworkCore;
using MotorHome.Api.Data;
using MotorHome.Api.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<MotorHomeDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("MotorHome")));
builder.Services.AddScoped<PasswordHashService>();
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

app.UseAuthorization();

app.MapControllers();

app.Run();
