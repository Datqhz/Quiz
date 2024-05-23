using Microsoft.AspNetCore.Mvc;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Controllers
{
    [ApiController]
    [Route("api/study-set")]
    public class StudySetController : ControllerBase
    {
        private readonly IStudySetRepository studySetRepository;
        public StudySetController(IStudySetRepository studySetRepository){
            this.studySetRepository = studySetRepository;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await studySetRepository.GetAll();
            return Ok(data);
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await studySetRepository.GetById(id);
            return Ok(data);
        }
        [HttpGet("test")]
        public IActionResult Test()
        {
            return Ok("Test");
        }

    }
}