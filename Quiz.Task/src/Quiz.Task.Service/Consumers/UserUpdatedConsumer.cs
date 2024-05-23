using MassTransit;
using Quiz.Common.Repository;
using Quiz.MyUser.Contract;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Consumers
{
    public class UserUpdatedConsumer : IConsumer<UserUpdated>
    {
        
        private readonly IRepository<UserInfo> repository;
        public UserUpdatedConsumer(IRepository<UserInfo> repository)
        {
            this.repository = repository;
        }
        public async System.Threading.Tasks.Task Consume(ConsumeContext<UserUpdated> context)
        {
            var message = context.Message;
            var item = await repository.GetById(message.Id);
            if (item == null)
            {
                return;
            }
            item.UserName = message.UserName;
            if(message.Image != ""){
                item.Image = Convert.FromBase64String(message.Image);
            }
            await repository.Update(item);
        }
    }
}