
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Quiz.Common.Authentication;
using Quiz.Common.MassTransit;
using Quiz.Common.Middleware;
using Quiz.Common.Repository;
using Quiz.MyUser.Service.Models;
using Quiz.MyUser.Service.Repository;
using Quiz.User.Service.DBContexts;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services
    .AddAuthenticationSetting()
    .AddAuthorizationSetting()
    .AddMassTransitWithRabbitMq();
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
builder.Services.AddDbContext<UserServiceContext>();
builder.Services.AddSingleton<AuthenticationHandler, AuthenticationHandler>();
builder.Services.AddTransient<IAccountRepository, AccountRepository>();
builder.Services.AddTransient<IRepository<UserInfo>, UserInfoRepository>();
builder.Services.AddTransient<IRepository<Group>, GroupRepository>();
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// using (var scope = app.Services.CreateScope())
// {
//     var services = scope.ServiceProvider;
//     var context = services.GetRequiredService<UserServiceContext>();
//     context.Database.Migrate(); // Apply migrations and create database if it doesn't exist
// }

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// app.UseHttpsRedirection();
// Use CORS policy
app.UseCors("AllowAllOrigins");
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<ErrorHandlingMiddleware>();
app.MapControllers();

app.Run();
