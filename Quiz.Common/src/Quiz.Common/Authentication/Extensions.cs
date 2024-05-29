using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Quiz.Common.Authentication
{
    using Microsoft.AspNetCore.Authentication.JwtBearer;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.IdentityModel.Tokens;
    using Quiz.Common.Identity;
    using Quiz.Common.Settings;

    public static class Extensions
    {
        public static IServiceCollection AddAuthenticationSetting(this IServiceCollection services)
        {
            // string rootFolderPath = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName, ".env");
            // DotNetEnv.Env.Load(rootFolderPath);
            services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(x =>
            {
                Console.WriteLine($"issuer: {Environment.GetEnvironmentVariable("ISSUER")}");
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidIssuer = Environment.GetEnvironmentVariable("ISSUER"),
                    ValidAudience = Environment.GetEnvironmentVariable("AUDIENCE"),
                    IssuerSigningKey = new SymmetricSecurityKey(
                        System.Text.Encoding.UTF8.GetBytes(Environment.GetEnvironmentVariable("KEY"))
                    ),
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true

                };
                x.MapInboundClaims = false;
            });
            return services;
        }
        public static IServiceCollection AddAuthorizationSetting(this IServiceCollection services)
        {
            services.AddAuthorization(option =>
            {
                option.AddPolicy(IdentityData.TeacherPolicyName, p =>
                {
                    p.RequireClaim(IdentityData.ClaimName, "teacher");
                });

                option.AddPolicy(IdentityData.StudentPolicyName, p =>
                {
                    p.RequireClaim(IdentityData.ClaimName, "student");
                });
            });
            return services;
        }
    }
}