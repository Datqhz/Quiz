using Microsoft.AspNetCore.Authentication;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Quiz.Common.Authentication;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services
    .AddAuthenticationSetting()
    .AddAuthorizationSetting();
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins",
        builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyMethod()
                   .AllowAnyHeader();
        });
});
builder.Configuration.AddJsonFile("ocelot.json", optional: false, reloadOnChange: true);
builder.Services.AddOcelot(builder.Configuration);
builder.Services.AddSingleton<AuthenticationHandler, AuthenticationHandler>();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseHttpsRedirection();
app.UseCors("AllowAllOrigins");
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

await app.UseOcelot();

app.Run();
