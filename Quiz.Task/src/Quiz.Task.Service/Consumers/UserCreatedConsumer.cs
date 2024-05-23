using MassTransit;
using Quiz.Common.Repository;
using Quiz.MyUser.Contract;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Consumers
{
    public class UserCreatedConsumer : IConsumer<UserCreated>
    {
        
        private readonly IRepository<UserInfo> repository;
        public UserCreatedConsumer(IRepository<UserInfo> repository)
        {
            this.repository = repository;
        }
        public async System.Threading.Tasks.Task Consume(ConsumeContext<UserCreated> context)
        {
            var message = context.Message;
            var item = await repository.GetById(message.Id);
            if (item != null)
            {
                return;
            }
            
            item = new UserInfo
            {
                Id = message.Id,
                UserName = message.UserName,
                Image = Convert.FromBase64String(message.Image),
                CreateDate = message.CreatedDate,
                AccountId = message.AccountId,
                GroupId = message.GroupId
            };
            await repository.Insert(item);
        }
    }
}