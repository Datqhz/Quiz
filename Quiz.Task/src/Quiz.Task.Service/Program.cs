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

// Add services to the container.
builder.Services.AddSingleton<TaskServiceContext, TaskServiceContext>();
builder.Services.AddSingleton<IRepository<Account>, AccountRepository>();
builder.Services.AddSingleton<ICardRepository, CardRepository>();
builder.Services.AddSingleton<IClassRepository, ClassRepository>();
builder.Services.AddSingleton<IFolderRepository, FolderRepository>();
builder.Services.AddSingleton<IFolderDetailRepository, FolderDetailRepository>();
builder.Services.AddSingleton<IMemberRepository, MemberRepository>();
builder.Services.AddSingleton<IStudySetRepository, StudySetRepository>();
builder.Services.AddSingleton<IRepository<Group>, GroupRepository>();
builder.Services.AddSingleton<IRepository<UserInfo>, UserInfoRepository>();
builder.Services
    .AddAuthenticationSetting()
    .AddAuthorizationSetting()
    .AddMassTransitWithRabbitMq();
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
app.UseMiddleware<ErrorHandlingMiddleware>();
app.UseHttpsRedirection();

// app.UseAuthorization();

app.MapControllers();

app.Run();
