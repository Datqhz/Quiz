
using Microsoft.AspNetCore.Builder;
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
    
builder.Services.AddControllers();
builder.Services.AddDbContext<UserServiceContext>();
builder.Services.AddSingleton<AuthenticationHandler, AuthenticationHandler>();
builder.Services.AddTransient<IAccountRepository, AccountRepository>();
builder.Services.AddTransient<IRepository<UserInfo>, UserInfoRepository>();
builder.Services.AddTransient<IRepository<Group>, GroupRepository>();
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

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<ErrorHandlingMiddleware>();
app.MapControllers();

app.Run();
