using MassTransit;
using Quiz.Common.Repository;
using Quiz.MyUser.Contract;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Consumers
{
    public class GroupCreatedConsumer : IConsumer<GroupCreated>
    {
        
        private readonly IRepository<Group> groupRepository;
        public GroupCreatedConsumer(IRepository<Group> groupRepository)
        {
            this.groupRepository = groupRepository;
        }
        public async System.Threading.Tasks.Task Consume(ConsumeContext<GroupCreated> context)
        {
            var message = context.Message;
            var item = await groupRepository.GetById(message.Id);
            if (item != null)
            {
                return;
            }
            
            item = new Group
            {
                Id = message.Id,
                Name = message.GroupName,
            };
            await groupRepository.Insert(item);
        }
    }
}