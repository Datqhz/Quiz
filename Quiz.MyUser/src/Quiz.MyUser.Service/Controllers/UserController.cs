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
    [Route("api/user")]
    [Authorize]
    public class UserController : ControllerBase
    {

        private readonly IRepository<UserInfo> repository;
        private readonly IPublishEndpoint publishEndpoint;
        public UserController(IRepository<UserInfo> repository, IPublishEndpoint publishEndpoint)
        {
            this.repository = repository;
            this.publishEndpoint = publishEndpoint;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await repository.GetAll();
            return Ok(new ResponseModel<IEnumerable<UserInfo>>
            {
                EC = 200,
                EM = "Get all user successful!",
                DT = data
            });
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await repository.GetById(id);
            if (data == null)
            {
                return NotFound(new ResponseModel<UserInfo>
                {
                    EC = 404,
                    EM = "User has id doesn't exsits!",
                    DT = data
                }
                );
            }
            return Ok(new ResponseModel<UserInfo>
            {
                EC = 200,
                EM = "Get user by id" + id + " successful!",
                DT = data
            });
        }
        [HttpPut]
        public async Task<ActionResult> Update(UpdateUserDto userDto)
        {
            var user = await repository.GetById(userDto.Id);
            if (user == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "User has id doesn't exsits!",
                    DT = ""
                });
            }
            user.UserName = userDto.Username;
            if (userDto.Image != "")
            {
                user.Image = Convert.FromBase64String(userDto.Image);
            }
            using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                var rs_user = await repository.Update(user);
                scope.Complete();
                await publishEndpoint.Publish(new UserUpdated(rs_user.Id, rs_user.UserName, userDto.Image));
                return Ok(new ResponseModel<UserInfo>
                {
                    EC = 200,
                    EM = "Update user info successful!",
                    DT = rs_user
                });
            }
        }
    }
}