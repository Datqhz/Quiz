
using System.Transactions;
using MassTransit;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Quiz.Common.Authentication;
using Quiz.Common.Global;
using Quiz.Common.Repository;
using Quiz.Common.Responses;
using Quiz.MyUser.Contract;
using Quiz.MyUser.Service.Dtos;
using Quiz.MyUser.Service.Models;
using Quiz.MyUser.Service.Repository;
namespace Quiz.MyUser.Service.Controllers
{
    [ApiController]
    [Route("api/account")]
    [Authorize]
    public class AccountController : ControllerBase
    {
        private readonly IAccountRepository accountRepository;
        private readonly IRepository<UserInfo> userRepository;
        private readonly IRepository<Group> groupRepository;
        private readonly AuthenticationHandler authHandler;
        private readonly IPublishEndpoint publishEndpoint;
        private byte[] defaultImg = Convert.FromBase64String(GlobalVariable.defaultImg);
        public AccountController(IAccountRepository accountRepository, IRepository<UserInfo> userRepository,
         IRepository<Group> groupRepository,AuthenticationHandler authHandler, IPublishEndpoint publishEndpoint){
            this.accountRepository = accountRepository;
            this.userRepository = userRepository;
            this.groupRepository = groupRepository;
            this.authHandler = authHandler;
            this.publishEndpoint = publishEndpoint;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await accountRepository.GetAll();
            return Ok(new ResponseModel<IEnumerable<Account>>
                {
                    EC = 200,
                    EM = "Get all account successful!",
                    DT = data
                });
        }
        
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await accountRepository.GetById(id);
            if(data == null)
            {
                return Ok(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Account has id doesn't exsits!",
                    DT = ""
                });
            }
            return Ok(new ResponseModel<Account>
                {
                    EC = 200,
                    EM = "Find account has Id equal " + id + " successful!" ,
                    DT = data
                });
        }
        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> Insert(CreateAccountDto accountDto)
        {
            string passwordHash = BCrypt.Net.BCrypt.HashPassword(accountDto.Password);
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled)){
                var account = await accountRepository.Insert(new Account
                {
                    Email = accountDto.Email,
                    Password = passwordHash,
                });
                var user = await userRepository.Insert(new UserInfo
                {
                    UserName = accountDto.Username,
                    Image = defaultImg,
                    CreateDate = DateTime.Now,
                    AccountId = account.Id,
                    GroupId = accountDto.GroupId,
                });
                scope.Complete();
                await publishEndpoint.Publish(new AccountCreated(account.Id, account.Email, passwordHash));
                await publishEndpoint.Publish(new UserCreated(user.Id, user.UserName, GlobalVariable.defaultImg, user.CreateDate, user.AccountId, user.GroupId));
                return CreatedAtAction(nameof(GetById), new {id = account.Id}, new ResponseModel<Account>
                {
                    EC = 200,
                    EM = "Create account successful!" ,
                    DT = account
                });
            }
        }
        [HttpPut]
        public async Task<ActionResult> Update(UpdateAccountDto accountDto)
        {
            var account = await accountRepository.GetById(accountDto.Id);
            if(account == null){
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Account has id doesn't exsits!" ,
                    DT = ""
                });
            }
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled)){
                var rs_account = await accountRepository.Update(new Account
                {
                    Id = accountDto.Id,
                    Email = accountDto.Email,
                    Password = accountDto.Password,
                });
                scope.Complete();
                await publishEndpoint.Publish(new AccountUpdated(rs_account.Id, rs_account.Email, rs_account.Password));
                return Ok(new ResponseModel<Account>
                {
                    EC = 200,
                    EM = "Update account successful!" ,
                    DT = rs_account
                });
            }
        }
        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<ActionResult> Login(LoginDto loginDto)
        {
            var account = await accountRepository.GetByEmail(loginDto.Email);
            if(account == null){
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Account has email doesn't exsits!" ,
                    DT = ""
                });
            }
            if(BCrypt.Net.BCrypt.Verify(loginDto.Password, account.Password))
            {
                var group = await groupRepository.GetById(account.User.GroupId);
                string token = authHandler.CreateToken(account.Email, account.Id.ToString(), group.Name);
                return Ok(new ResponseModel<string>
                {
                    EC = 200,
                    EM = "Login successful!" ,
                    DT = token
                });
            }else {
                return BadRequest(new ResponseModel<string>
                {
                    EC = 400,
                    EM = "Wrong password!" ,
                    DT = ""
                });
            }
        }
    }
}