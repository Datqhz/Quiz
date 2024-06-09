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
    [Route("api/member")]
    public class MemberController :ControllerBase
    {
        private readonly IMemberRepository memberRepository;
        private readonly IRepository<UserInfo> userRepository;
        private readonly IClassRepository classRepository;
        public MemberController(IMemberRepository memberRepository, IClassRepository classRepository, IRepository<UserInfo> userRepository)
        {
            this.memberRepository = memberRepository;
            this.classRepository = classRepository;
            this.userRepository = userRepository;
        }

        // Get all member
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await memberRepository.GetAll();
            return Ok( new ResponseModel<IEnumerable<MemberDto>>
            {
                EC = 200,
                EM = "Get all Member successful!",
                DT = data.Select(e_Member => e_Member.AsDto()).ToList()
            });
        }
        // Get member record by id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await memberRepository.GetById(id);
            if(data == null){
                return NotFound( new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Member has id doesn't exist",
                    DT = ""
                });
            }
            return Ok( new ResponseModel<MemberDto>
            {
                EC = 200,
                EM = "Get member successful!",
                DT = data.AsDto()
            });
        }
        // Create new member record
        [HttpPost]
        public async Task<IActionResult> CreateMember(CreateMemberDto createMemberDto)
        {
            var user = await userRepository.GetById(createMemberDto.UserId);
            if(user == null)
            {
                return NotFound( new ResponseModel<string>
                    {
                        EC = 404,
                        EM = "User has id doesn't exits!",
                        DT = ""
                    });
            }
            var e_class = await classRepository.GetById(createMemberDto.ClassId);
            if(e_class == null)
            {
                return NotFound( new ResponseModel<string>
                    {
                        EC = 404,
                        EM = "Class has id doesn't exits!",
                        DT = ""
                    });
            }
            var created_Member = await memberRepository.Insert(new Member
                {
                    ClassId = createMemberDto.ClassId,
                    UserId = createMemberDto.UserId
                });
            if(created_Member == null)
            {
                return BadRequest( new ResponseModel<string>
                    {
                        EC = 500,
                        EM = "Something wrong in process!",
                        DT = ""
                    });
            }
            var res = new ResponseModel<MemberDto>
                {
                    EC = 201,
                    EM = "Create Member record successful!" ,
                    DT = created_Member.AsDto()
                };
            return CreatedAtAction(nameof(GetById), new {id = created_Member.Id}, res);
        }
        // Delete member record
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMember(int id)
        {
            var deleted_Member = await memberRepository.GetById(id);
            if(deleted_Member == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Member has id doesn't exits!",
                    DT = ""
                });
            }
            await memberRepository.Delete(id);
            return Ok(new ResponseModel<MemberDto>
                {
                    EC = 200,
                    EM = "Delete member successful!",
                    DT = deleted_Member.AsDto()
                });
        }
        // Get all member record in class has class id
        [HttpGet("class/{classId}")]
        public async Task<IActionResult> GetAllMemberOfClass(int classId)
        {
            var data = await memberRepository.GetByClassId(classId);
            return Ok( new ResponseModel<IEnumerable<MemberDto>>
            {
                EC = 200,
                EM = "Get all members successful!",
                DT = data.Select(member => member.AsDto()).ToList()
            });
        }
    }
}