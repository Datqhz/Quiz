using MassTransit;
using Quiz.Common.Repository;
using Quiz.MyUser.Contract;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Consumers
{
    public class AccountCreatedConsumer : IConsumer<AccountCreated>
    {
        
        private readonly IRepository<Account> repository;
        public AccountCreatedConsumer(IRepository<Account> repository)
        {
            this.repository = repository;
        }
        public async System.Threading.Tasks.Task Consume(ConsumeContext<AccountCreated> context)
        {
            var message = context.Message;
            var item = await repository.GetById(message.Id);
            if (item != null)
            {
                return;
            }
            
            item = new Account
            {
                Id = message.Id,
                Email = message.Email,
                Password = message.Password,

            };
            await repository.Insert(item);
        }
    }
}