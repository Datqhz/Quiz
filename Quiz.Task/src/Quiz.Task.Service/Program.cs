using Microsoft.EntityFrameworkCore;
using Quiz.Common.Authentication;
using Quiz.Common.MassTransit;
using Quiz.Common.Middleware;
using Quiz.Common.Repository;
using Quiz.MyUser.Service.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repositories;
using Quiz.Task.Service.Repository;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddHttpsRedirection(options =>
{
    options.HttpsPort = 443; // Set the desired HTTPS port
});

// Add services to the container.
builder.Services.AddDbContext<TaskServiceContext>();
builder.Services.AddTransient<IRepository<Account>, AccountRepository>();
builder.Services.AddTransient<AuthenticationHandler, AuthenticationHandler>();
builder.Services.AddTransient<ICardRepository, CardRepository>();
builder.Services.AddTransient<IClassRepository, ClassRepository>();
builder.Services.AddTransient<IFolderRepository, FolderRepository>();
builder.Services.AddTransient<IFolderDetailRepository, FolderDetailRepository>();
builder.Services.AddTransient<IMemberRepository, MemberRepository>();
builder.Services.AddTransient<IStudySetRepository, StudySetRepository>();
builder.Services.AddTransient<IRepository<Group>, GroupRepository>();
builder.Services.AddTransient<IRepository<UserInfo>, UserInfoRepository>();
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
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// // Ensure the database is created
// using (var scope = app.Services.CreateScope())
// {
//     var services = scope.ServiceProvider;
//     var context = services.GetRequiredService<TaskServiceContext>();
//     context.Database.Migrate(); // Apply migrations and create database if it doesn't exist
// }


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowAllOrigins");
app.UseAuthentication();
app.UseAuthorization();
app.UseMiddleware<ErrorHandlingMiddleware>();
// app.UseHttpsRedirection();



app.MapControllers();

app.Run();
