using System.Transactions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Quiz.Common.Repository;
using Quiz.Common.Responses;
using Quiz.Task.Service.Extensions;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;
using Quiz.Task.Service.RequestDtos;
using Quiz.Task.Service.ResponseDtos;

namespace Quiz.Task.Service.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/class")]
    public class ClassController : ControllerBase
    {
        private readonly IClassRepository classRepository;
        private readonly IMemberRepository memberRepository;
        private readonly IRepository<UserInfo> userRepository;
        public ClassController(IClassRepository classRepository, IMemberRepository memberRepository, IRepository<UserInfo> userRepository)
        {
            this.classRepository = classRepository;
            this.memberRepository = memberRepository;
            this.userRepository = userRepository;
        }

        // Get all class without conditions
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await classRepository.GetAll();
            return Ok( new ResponseModel<IEnumerable<ClassDto>>
            {
                EC = 200,
                EM = "Get all class successful!",
                DT = data.Select(e_class => e_class.AsDto()).ToList()
            });
        }
        // Get class by id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await classRepository.GetById(id);
            if(data == null){
                return NotFound( new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Class has id  doesn't exsist",
                    DT = ""
                });
            }
            return Ok( new ResponseModel<ClassDto>
            {
                EC = 200,
                EM = "Get all class successful!",
                DT = data.AsDto()
            });
        }
        // Create class
        [HttpPost]
        public async Task<IActionResult> CreateClass(CreateClassDto createClassDto)
        {
             var user = await userRepository.GetById(createClassDto.UserId);
            if(user == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "User has id doesn't exsits!",
                    DT = ""
                });
            }
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                var created_class = await classRepository.Insert(new Class
            {
                ClassName = createClassDto.ClassName,
                Description = createClassDto.Description,
                UserId = createClassDto.UserId,
                CreateDate = DateTime.Now
            });
            if(created_class == null)
            {
                return BadRequest( new ResponseModel<string>
                {
                    EC = 500,
                    EM = "Something wrong in process!",
                    DT = ""
                });
            }
            await memberRepository.Insert(new Member{
                ClassId = created_class.Id,
                UserId = created_class.UserId,
            });
            scope.Complete();
            var res = new ResponseModel<ClassDto>
                {
                    EC = 201,
                    EM = "Create study set successful!" ,
                    DT = created_class.AsDto()
                };
            return CreatedAtAction(nameof(GetById), new {id = created_class.Id}, res);
            }
        }
        // Update class
        [HttpPut]
        public async Task<IActionResult> UpdateClass(UpdateClassDto updateClassDto)
        {
            var update_class = await classRepository.GetById(updateClassDto.Id);
            if(update_class == null)
            {
                return Ok(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Class has id doesn't exsits!",
                    DT = ""
                });
            }
            update_class.ClassName = updateClassDto.ClassName;
            update_class.Description = updateClassDto.Description;
            await classRepository.Update(update_class);
            return Ok(new ResponseModel<ClassDto>
            {
                EC = 200,
                EM = "Update class successful!",
                DT = update_class.AsDto()
            });
        }
        // Delete class by id
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteClass(int id)
        {
            var deleted_class = await classRepository.GetById(id);
            if(deleted_class == null)
            {
                return Ok(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Class has id doesn't exsits!",
                    DT = ""
                });
            }
            await classRepository.Delete(id);
            return Ok(new ResponseModel<ClassDto>
                {
                    EC = 200,
                    EM = "Delete class successful!",
                    DT = deleted_class.AsDto()
                });
        }
        // Get all class user join
        [HttpGet("user-joined/{id}")]
        public async Task<IActionResult> GetClassesUserJoin(int id)
        {
            var classes = await classRepository.GetByUserId(id);
            return Ok(new ResponseModel<IEnumerable<ClassDto>>
            {
                EC = 200,
                EM = "Get all class user join successful!",
                DT = classes.Select(e => e.AsDto()).ToList()
            });
        }
    }
}