using MassTransit;
using Quiz.Common.Repository;
using Quiz.MyUser.Contract;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Consumers
{
    public class AccountUpdatedConsumer : IConsumer<AccountUpdated>
    {
        
        private readonly IRepository<Account> repository;
        public AccountUpdatedConsumer(IRepository<Account> repository)
        {
            this.repository = repository;
        }
        public async System.Threading.Tasks.Task Consume(ConsumeContext<AccountUpdated> context)
        {
            var message = context.Message;
            var item = await repository.GetById(message.Id);
            if (item == null)
            {
                item = new Account
            {
                Id = message.Id,
                Email = message.Email,
                Password = message.Password,
                
            };
            await repository.Insert(item);
            }
            
            item.Email = message.Email;
            item.Password = message.Password;
            await repository.Update(item);
        }
    }
}