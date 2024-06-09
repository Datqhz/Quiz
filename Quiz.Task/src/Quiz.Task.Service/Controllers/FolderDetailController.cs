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
    [Route("api/folder-detail")]
    public class FolderDetailController : ControllerBase
    {
        private readonly IFolderDetailRepository folderDetailRepository;
        private readonly IFolderRepository folderRepository;
        private readonly IStudySetRepository studySetRepository;
        public FolderDetailController(IFolderDetailRepository folderDetailRepository, IStudySetRepository studySetRepository, IFolderRepository folderRepository)
        {
            this.folderDetailRepository = folderDetailRepository;
            this.studySetRepository = studySetRepository;
            this.folderRepository = folderRepository;
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await folderDetailRepository.GetById(id);
            if (data == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = $"FolderDetail has id =  {id} doesn't exsist",
                    DT = ""
                });
            }
            return Ok(new ResponseModel<FolderDetailDto>
            {
                EC = 200,
                EM = "Get folderDetail successful!",
                DT = data.AsDto()
            });
        }
        [HttpPost]
        public async Task<IActionResult> CreateFolderDetail(CreateFolderDetailDto createFolderDetailDto)
        {
            var folder = await folderRepository.GetById(createFolderDetailDto.FolderId);
            if (folder == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = $"Folder has id = {createFolderDetailDto.FolderId} doesn't exits!",
                    DT = ""
                });
            }
            var studySet = await studySetRepository.GetById(createFolderDetailDto.StudySetId);
            if (studySet == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = $"Study set has id = {createFolderDetailDto.StudySetId} doesn't exits!",
                    DT = ""
                });
            }
            var created_FolderDetail = await folderDetailRepository.Insert(new FolderDetail
            {
                FolderId = createFolderDetailDto.FolderId,
                StudySetId = createFolderDetailDto.StudySetId
            });
            if (created_FolderDetail == null)
            {
                return BadRequest(new ResponseModel<string>
                {
                    EC = 500,
                    EM = "Something wrong in process!",
                    DT = ""
                });
            }
            var res = new ResponseModel<FolderDetailDto>
            {
                EC = 201,
                EM = "Create folder detail record successful!",
                DT = created_FolderDetail.AsDto()
            };
            return CreatedAtAction(nameof(GetById), new { id = created_FolderDetail.Id }, res);
        }
        [HttpPost("multiple")]
        public async Task<IActionResult> CreateMultiFolderDetail(List<CreateFolderDetailDto> createFolderDetailDtos)
        {
            using(var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled)){
                List<FolderDetail> details = new List<FolderDetail>();
                foreach(var detail in createFolderDetailDtos){
                    var created_FolderDetail = await folderDetailRepository.Insert(new FolderDetail
                    {
                        FolderId = detail.FolderId,
                        StudySetId = detail.StudySetId
                    });
                    if (created_FolderDetail == null)
                    {
                        return BadRequest(new ResponseModel<string>
                        {
                            EC = 500,
                            EM = "Something wrong in process!",
                            DT = ""
                        });
                    }
                    details.Add(created_FolderDetail);  
                }
                scope.Complete();
                 var res = new ResponseModel<List<FolderDetailDto>>
                {
                    EC = 201,
                    EM = "Create multiple folder detail record successful!",
                    DT = details.Select(fd => fd.AsDto()).ToList()
                };
                return Created("", res);
            }
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFolderDetail(int id)
        {
            var deleted_FolderDetail = await folderDetailRepository.GetById(id);
            if (deleted_FolderDetail == null)
            {
                return Ok(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "FolderDetail has id doesn't exits!",
                    DT = ""
                });
            }
            await folderDetailRepository.Delete(id);
            return Ok(new ResponseModel<FolderDetailDto>
            {
                EC = 200,
                EM = "Delete folderDetail successful!",
                DT = deleted_FolderDetail.AsDto()
            });
        }
    }
}