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
    [Route("api/folder")]
    public class FolderController : ControllerBase
    {
        private readonly IFolderRepository folderRepository;
        private readonly IFolderDetailRepository folderDetailRepository;
        private readonly IRepository<UserInfo> userRepository;
        private readonly IClassRepository classRepository;
        private readonly IStudySetRepository studySetRepository;
        public FolderController(IFolderRepository folderRepository, IClassRepository classRepository,
         IStudySetRepository studySetRepository, IRepository<UserInfo> userRepository,
         IFolderDetailRepository folderDetailRepository)
        {
            this.folderRepository = folderRepository;
            this.classRepository = classRepository;
            this.userRepository = userRepository;
            this.studySetRepository = studySetRepository;
            this.folderDetailRepository = folderDetailRepository;
        }
        // Get all without conditions
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            IEnumerable<Folder> data = await folderRepository.GetAll(); ;
            return Ok(new ResponseModel<IEnumerable<FolderDto>>
            {
                EC = 200,
                EM = "Get all Folder successful!",
                DT = data.Select(Folder => Folder.AsDto()).ToList()
            });
        }
        // Get Folder by id
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var data = await folderRepository.GetById(id);
            if (data == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Folder has id  doesn't exsist",
                    DT = ""
                });
            }
            return Ok(new ResponseModel<FolderDto>
            {
                EC = 200,
                EM = "Get Folder successful!",
                DT = data.AsDto()
            });
        }
        // Create folder
        [HttpPost]
        public async Task<IActionResult> CreateFolder(CreateFolderDto createFolderDto)
        {
            Folder temp = new Folder();
            var user = await userRepository.GetById(createFolderDto.UserId);
            if (user == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "User has id doesn't exsits!",
                    DT = ""
                });
            }
            if (createFolderDto.ClassId != 0)
            {
                var e_class = await classRepository.GetById(createFolderDto.ClassId);
                if (e_class == null)
                {
                    return NotFound(new ResponseModel<string>
                    {
                        EC = 404,
                        EM = "Class has id doesn't exsits!",
                        DT = ""
                    });
                }
                temp.ClassId = createFolderDto.ClassId;
            }
            temp.FolderName = createFolderDto.FolderName;
            temp.UserId = createFolderDto.UserId;
            var created_Folder = await folderRepository.Insert(temp);
            if (created_Folder == null)
            {
                return BadRequest(new ResponseModel<string>
                {
                    EC = 500,
                    EM = "Something wrong in process!",
                    DT = ""
                });
            }
            var res = new ResponseModel<FolderDto>
            {
                EC = 201,
                EM = "Create study set successful!",
                DT = created_Folder.AsDto()
            };
            return CreatedAtAction(nameof(GetById), new { id = created_Folder.Id }, res);
        }
        // Update folder
        [HttpPut]
        public async Task<IActionResult> UpdateFolder(UpdateFolderDto updateFolderDto)
        {
            var updateFolder = await folderRepository.GetById(updateFolderDto.Id);
            if (updateFolder == null)
            {
                return NotFound(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Folder has id doesn't exsits!",
                    DT = ""
                });
            }
            if (updateFolderDto.ClassId != 0)
            {
                var e_class = await classRepository.GetById(updateFolderDto.ClassId);
                if (e_class == null)
                {
                    return NotFound(new ResponseModel<string>
                    {
                        EC = 404,
                        EM = "Class has id doesn't exsits!",
                        DT = ""
                    });
                }
                updateFolder.ClassId = updateFolderDto.ClassId;
            }
            else
            {
                updateFolder.ClassId = null;
            }
            updateFolder.FolderName = updateFolderDto.FolderName;
            await folderRepository.Update(updateFolder);
            var res = new ResponseModel<FolderDto>
            {
                EC = 200,
                EM = "Update study set successful!",
                DT = updateFolder.AsDto()
            };
            return Ok(res);
        }
        // Delete folder
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFolder(int id)
        {
            var deleted_Folder = await folderRepository.GetById(id);
            if (deleted_Folder == null)
            {
                return Ok(new ResponseModel<string>
                {
                    EC = 404,
                    EM = "Folder has id doesn't exsits!",
                    DT = ""
                });
            }
            var folderDetails = await folderDetailRepository.GetByFolderId(id);
            using (var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                foreach (var folderDetail in folderDetails)
                {
                    await folderDetailRepository.Delete(folderDetail.Id);
                }
                await folderRepository.Delete(id);
                scope.Complete();
                return Ok(new ResponseModel<FolderDto>
                {
                    EC = 200,
                    EM = "Delete Folder successful!",
                    DT = deleted_Folder.AsDto()
                });
            }

        }
        // Get all folder created by user has userId
        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetAllFolderByUserId(int userId, [FromQuery] int? page = null, [FromQuery] int? limit = null)
        {
            int totalPages = 0;
            IEnumerable<Folder> data;
            if (page == null || limit == null)
            {
                data = await folderRepository.GetByUserId(userId);
            }
            else
            {
                totalPages = await folderRepository.CountOfPageFolderByUserId(userId, (int)limit);
                data = await folderRepository.GetByUserIdWithPage(userId, (int)page, (int)limit);
            }
            return Ok(new ResponseModel<Object>
            {
                EC = 200,
                EM = "Get all Folder by userId successful!",
                DT = new
                {
                    TotalPage = totalPages,
                    Folders = data.Select(Folder => Folder.AsDto()).ToList()
                }
            });
        }
        // Get all folder in class has classId
        [HttpGet("class/{classId}")]
        public async Task<IActionResult> GetAllFolderByClassId(int classId, [FromQuery] int? page = null, [FromQuery] int? limit = null)
        {
            int totalPages = 0;
            IEnumerable<Folder> data;
            if (page == null || limit == null)
            {
                data = await folderRepository.GetByClassId(classId);
            }
            else
            {
                totalPages = await folderRepository.CountOfPageFolderByClassId(classId, (int)limit);
                data = await folderRepository.GetByClassIdWithPage(classId, (int)page, (int)limit);
            }
            return Ok(new ResponseModel<Object>
            {
                EC = 200,
                EM = "Get all Folder by class id successful!",
                DT = new
                {
                    TotalPage = totalPages,
                    Folders = data.Select(Folder => Folder.AsDto()).ToList()
                }
            });
        }
    }
}