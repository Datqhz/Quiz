using System.Reflection;
using MassTransit;
using MassTransit.Configuration;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Quiz.Common.Settings;

namespace Quiz.Common.MassTransit
{
    public static class Extensions
    {
        public static IServiceCollection AddMassTransitWithRabbitMq(this IServiceCollection services){
            services.AddMassTransit(configure =>
            {

                configure.AddConsumers(Assembly.GetEntryAssembly());

                configure.UsingRabbitMq((context, configurator) =>
                {
                    var configuration = context.GetService<IConfiguration>();
                    var serviceSettings = configuration.GetSection(nameof(ServiceSettings)).Get<ServiceSettings>();
                    var rabbitMQSettings = configuration.GetSection(nameof(RabbitMQSettings)).Get<RabbitMQSettings>();
                    configurator.Host(rabbitMQSettings.Host);
                    configurator.ConfigureEndpoints(context, new KebabCaseEndpointNameFormatter(serviceSettings.ServiceName ,false));
                    configurator.UseMessageRetry(retryConfigurator =>
                    {
                        retryConfigurator.Interval(3, TimeSpan.FromSeconds(5)); // try resend message 3 times with delay 5s on per turn
                    });
                });
                
            });
            return services;
        }
    }
}