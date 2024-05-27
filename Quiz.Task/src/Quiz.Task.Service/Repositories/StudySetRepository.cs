
using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;
using Quiz.Task.Service.ResponseDtos;

namespace Quiz.Task.Service.Repositories
{
    public class StudySetRepository : IStudySetRepository
    {
        private readonly TaskServiceContext _context;
        public StudySetRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<StudySet>> GetAll()
        {
            var data = await _context.StudySet
                                .Select(e => new StudySet
                                {
                                    Id = e.Id,
                                    StudySetName = e.StudySetName,
                                    CreateDate = e.CreateDate,
                                    User = new UserInfo
                                    {
                                        Id = e.User.Id,
                                        UserName = e.User.UserName,
                                        Image = e.User.Image
                                    },
                                    Cards = e.Cards.Select(c => new Card
                                    {
                                        Id = c.Id,
                                        Term = c.Term,
                                        Definition = c.Definition
                                    }).ToList()
                                })
                                .OrderByDescending(e => e.CreateDate)
                                .ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<StudySet>> GetAll(string query)
        {
            var data = await _context.StudySet.ToListAsync();
            return data;
        }
        public async Task<StudySet> GetById(int id)
        {
#pragma warning disable CS8603 // Possible null reference return.
            return await _context.StudySet
                                .Where(e => e.Id == id)
                                .Select(e => new StudySet
                                {
                                    Id = e.Id,
                                    StudySetName = e.StudySetName,
                                    CreateDate = e.CreateDate,
                                    UserId = e.UserId,
                                    
                                    User = new UserInfo
                                    {
                                        Id = e.User.Id,
                                        UserName = e.User.UserName,
                                        Image = e.User.Image
                                    },
                                    Cards = e.Cards.Select(c => new Card
                                    {
                                        Id = c.Id,
                                        Term = c.Term,
                                        Definition = c.Definition
                                    }).ToList()
                                })
                                .FirstOrDefaultAsync();
#pragma warning restore CS8603 // Possible null reference return.
        }
        public async Task<StudySet> Insert(StudySet entity)
        {
            var StudySet = await _context.StudySet.AddAsync(entity);
            await Save();
            return StudySet.Entity;
        }
        public async Task<StudySet> Update(StudySet entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<StudySet> Delete(int Id)
        {
            var entity = await _context.StudySet.FindAsync(Id);
            _context.StudySet.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<StudySet>> GetByUserId(int userId)
        {
            return await _context.StudySet
                                .Include(e => e.User)
                                .Include(e => e.Cards)
                                .OrderByDescending(e => e.CreateDate)
                                .Where(c => c.UserId == userId)
                                .ToListAsync();

        }
        public async Task<IEnumerable<StudySet>> GetByFolderId(int folderId)
        {
            var query = from studySet in _context.StudySet
                    join folder_detail in _context.FolderDetail
                    on studySet.Id equals folder_detail.StudySetId
                    where folder_detail.FolderId.Equals(folderId) 
                    select new StudySet
                    {
                        Id = studySet.Id,
                        StudySetName = studySet.StudySetName,
                        CreateDate = studySet.CreateDate,
                        User = studySet.User,
                        UserId = studySet.UserId,
                        Cards = studySet.Cards,
                        FolderDetails = studySet.FolderDetails,
                    };
            return await query
                                .OrderByDescending(e => e.CreateDate)
                                .ToListAsync();
        }
        public async Task<IEnumerable<StudySet>> GetByUserIdWithPage(int userId, int page, int limit)
        {
            var offset = (page - 1) * limit;
            return await _context.StudySet
                                .Include(e => e.User)
                                .Include(e => e.Cards)
                                .OrderByDescending(e => e.CreateDate)
                                .Where(c => c.UserId == userId)
                                .Skip(offset)
                                .Take(limit)
                                .ToListAsync();

        }
        public async Task<IEnumerable<StudySet>> GetByFolderIdWithPage(int folderId, int page, int limit)
        {
            var offset = (page - 1) * limit;
             var query = from studySet in _context.StudySet
                    join folder_detail in _context.FolderDetail
                    on studySet.Id equals folder_detail.StudySetId
                    where folder_detail.FolderId.Equals(folderId) 
                    select new StudySet
                    {
                        Id = studySet.Id,
                        StudySetName = studySet.StudySetName,
                        CreateDate = studySet.CreateDate,
                        User = studySet.User,
                        UserId = studySet.UserId,
                        Cards = studySet.Cards,
                        FolderDetails = studySet.FolderDetails,
                    };
            return await query
                                .OrderByDescending(e => e.CreateDate)
                                .Skip(offset)
                                .Take(limit)
                                .ToListAsync();
        }
        public async Task<IEnumerable<StudySet>> GetByRegex(int userId, string regex)
        {
            return await _context.StudySet
                                .FromSqlRaw("SELECT * FROM StudySet WHERE StudySetName REGEXP {0}", regex)
                                .Where(c => c.UserId == userId)
                                .Include(e => e.User)
                                .Include(e => e.Cards)
                                .Include(e => e.FolderDetails)
                                .OrderByDescending(e => e.CreateDate)
                                .ToListAsync();
        }
    }
}