using System.Transactions;
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
    [ApiController]
    [Route("api/study-set")]
    public class StudySetController : ControllerBase
    {
        private readonly IStudySetRepository studySetRepository;
        private readonly ICardRepository cardRepository;
        private readonly IRepository<UserInfo> userRepository;
        public StudySetController(IStudySetRepository studySetRepository, ICardRepository cardRepository, IRepository<UserInfo> userRepository){
            this.studySetRepository = studySetRepository;
            this.cardRepository = cardRepository;
            this.userRepository = userRepository;
        }

        // Get all studyset without conditions
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var data = await studySetRepository.GetAll();
            var rs = data.Select(studySet => studySet.AsDto()).ToList();
            return Ok(new ResponseModel<IEnumerable<StudySetDto>>
            {
                EC = 200,
                EM = "Get all study-set successful!",
                DT = rs
            });
        }
        // Get study set by id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await studySetRepository.GetById(id);
            if (data == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Study set has id doesn't exsits!",
                    DT = ""
                }
                );
            }
            return Ok(new ResponseModel<StudySetDto>
            {
                EC = 200,
                EM = "Get study set by id = " + id + " successful!",
                DT = data.AsDto()
            });
        }
        // Get all study set by user id
        [HttpGet("user/{id}")]
        public async Task<IActionResult> GetByUserId(int id, [FromQuery] int? page = null, [FromQuery] int? limit = null)
        {
            IEnumerable<StudySet> data;
            if(page == null || limit == null)
            {
                data  = await studySetRepository.GetByUserId(id);
            }else 
            {
                data = await studySetRepository.GetByUserIdWithPage(id, (int)page, (int)limit);
            }
            return Ok(new ResponseModel<IEnumerable<StudySetDto>>
            {
                EC = 200,
                EM = "Get study set by id = " + id + " successful!",
                DT = data.Select(studySet => studySet.AsDto()).ToList()
            });
        }
        // Create study set
        [HttpPost]
        public async Task<ActionResult> CreateStudySet(CreateStudySetDto studySetDto)
        {
            var user = await userRepository.GetById(studySetDto.UserId);
            if(user == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "User doesn't exsits!" ,
                    DT = ""
                });
            }
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                // insert new study set into database
                var studySet = await studySetRepository.Insert(new StudySet
                {
                    StudySetName = studySetDto.StudySetName,
                    CreateDate = DateTime.Now,
                    UserId = studySetDto.UserId,

                });
                // insert all new card into database
                foreach (var card in studySetDto.Cards){
                    var created_card = await cardRepository.Insert(new Card
                    {
                        Term = card.Term,
                        Definition = card.Definition,
                        StudySetId = studySet.Id
                    });
                    studySet.Cards.Add(created_card);
                }
                scope.Complete();
                // map study set to study set dto
                var dto = studySet.AsDto();
                return CreatedAtAction(nameof(GetById), new {id = studySet.Id}, new ResponseModel<StudySetDto>
                {
                    EC = 201,
                    EM = "Create study set successful!" ,
                    DT = dto
                });
            }
        }
        // Update study set
        [HttpPut]
        public async Task<ActionResult> UpdateStudySet(UpdateStudySetDto studySetDto)
        {
            // try find study set has id
            var studySet = await studySetRepository.GetById(studySetDto.Id);
            if(studySet == null){
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Study set has id doesn't exsits!" ,
                    DT = ""
                });
            }
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                studySet.StudySetName = studySetDto.StudySetName;
                // Update study set info
                var rs_studySet = await studySetRepository.Update(studySet);
                rs_studySet.Cards = new List<Card>();
                // Update cards in study set
                foreach (var card in studySetDto.Cards){
                    if(card.Task == 0)// create new card
                    {
                        var created_card = await cardRepository.Insert(new Card
                        {
                            Term = card.Term,
                            Definition = card.Definition,
                            StudySetId = rs_studySet.Id
                        });
                        rs_studySet.Cards.Add(created_card);
                    }else if(card.Task == 1)//upate card exsits
                    {
                        var updated_card = await cardRepository.GetById(card.Id);
                        if (updated_card == null){
                            return NotFound(new ResponseModel<string>
                            {
                                EC = 404,
                                EM = "Something wrong when process update card!" ,
                                DT = ""
                            });
                        }
                        updated_card.Term = card.Term;
                        updated_card.Definition = card.Definition;
                        await cardRepository.Update(updated_card);
                        rs_studySet.Cards.Add(updated_card);
                    }else if(card.Task == 2)// delete card
                    {
                        var temp_card = await cardRepository.GetById(card.Id);
                        if (temp_card == null){
                            return NotFound(new ResponseModel<string>
                            {
                                EC = 404,
                                EM = "Something wrong when process update card!" ,
                                DT = ""
                            });
                        }
                        await cardRepository.Delete(card.Id);
                    }else // 4 -> nothing
                    {
                        continue;
                    }
                }
                scope.Complete();
                return Ok(new ResponseModel<StudySetDto>
                {
                    EC = 200,
                    EM = "Update study set successful!" ,
                    DT = studySet.AsDto()
                });
            }
        }
        // Delete study set by id
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                var studySet = await studySetRepository.GetById(id);
                if (studySet == null){
                    return NotFound(new ResponseModel<string>
                    {
                        EC = 404,
                        EM = "Study set has id doesn't exsits" ,
                        DT = ""
                    });
                }
                await cardRepository.DeleteByStudySetId(id);
                await studySetRepository.Delete(id);
                scope.Complete();
                return Ok(new ResponseModel<StudySetDto>
                    {
                        EC = 200,
                        EM = "Delete study set successful!" ,
                        DT = studySet.AsDto()
                    });
            }
        }
        // Get all study set by folder id
        [HttpGet("folder/{id}")]
        public async Task<IActionResult> GetByFolderId(int id, [FromQuery] int? page = null, [FromQuery] int? limit = null)
        {
            IEnumerable<StudySet> data;
            if(page == null || limit == null)
            {
                data  = await studySetRepository.GetByFolderId(id);
            }else 
            {
                data = await studySetRepository.GetByFolderIdWithPage(id, (int)page, (int)limit);
            }
            return Ok(new ResponseModel<IEnumerable<StudySetDto>>
            {
                EC = 200,
                EM = "Get study set by id = " + id + " successful!",
                DT = data.Select(studySet => studySet.AsDto()).ToList()
            });
        }
        // find by regex
        [HttpGet("find")]
        public async Task<IActionResult> FindByRegex([FromQuery] int userId, [FromQuery] string regex)
        {
            var data = await studySetRepository.GetByRegex(userId, regex);
            return Ok(new ResponseModel<IEnumerable<StudySetDto>>
            {
                EC = 200,
                EM = "Get study set by regex = " + regex + " successful!",
                DT = data.Select(studySet => studySet.AsDto()).ToList()
            });
        }
    }
}