using System.Transactions;
using MassTransit;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Quiz.Common.Repository;
using Quiz.Common.Responses;
using Quiz.MyUser.Contract;
using Quiz.MyUser.Service.Dtos;
using Quiz.MyUser.Service.Models;
namespace Quiz.MyUser.Service.Controllers
{
    [ApiController]
    [Route("api/group")]
    [Authorize]
    public class GroupController : ControllerBase
    {
        private readonly IRepository<Group> groupRepository;
        private readonly IPublishEndpoint publishEndpoint;
        public GroupController(IRepository<Group> groupRepository, IPublishEndpoint publishEndpoint)
        {
            this.groupRepository = groupRepository;
            this.publishEndpoint = publishEndpoint;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await groupRepository.GetAll();
            return Ok(new ResponseModel<IEnumerable<Group>>
            {
                EC = 200,
                EM = "Get all group successful!",
                DT = data
            });
        }
        [HttpGet("{Id}")]
        public async Task<IActionResult> GetById(int Id)
        {
            var data = await groupRepository.GetById(Id);
            if (data == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Group has id doesn't exsits!",
                    DT = ""
                }
                );
            }
            return Ok(new ResponseModel<Group>
            {
                EC = 200,
                EM = "Get group by id" + Id + " successful!",
                DT = data
            });
        }
        [HttpPost]
        public async Task<IActionResult> Insert(CreateGroupDto createGroupDto)
        {
            using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                var group = await groupRepository.Insert(new Group
                {
                    Name = createGroupDto.Name,
                    Description = createGroupDto.Description,
                });
                scope.Complete();
                await publishEndpoint.Publish(new GroupCreated(group.Id, group.Name));
                return CreatedAtAction(nameof(GetById), new { Id = group.Id }, new ResponseModel<Group>
                {
                    EC = 200,
                    EM = "Update user info successful!",
                    DT = group
                });
            }
        }
    }
}