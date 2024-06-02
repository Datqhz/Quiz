
using Microsoft.EntityFrameworkCore;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Repositories
{
    public class FolderRepository : IFolderRepository
    {
        private readonly TaskServiceContext _context;
        public FolderRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Folder>> GetAll()
        {
            var data = await _context.Folder.ToListAsync();
            return data;
        }
        public async Task<IEnumerable<Folder>> GetAll(string query)
        {
            var data = await _context.Folder.ToListAsync();
            return data;
        }
        public async Task<Folder> GetById(int id)
        {
            var folderWithClass = await _context.Folder
                .Where(f => f.Id== id && f.ClassId != null)
                .Include(f => f.User)
                .Include(f => f.Class)
                .FirstOrDefaultAsync();

            // Get folders where ClassId is null and exclude Class
            var folderWithoutClass = await _context.Folder
                .Where(f => f.Id == id && f.ClassId == null)
                .Include(f => f.User)
                .OrderByDescending(f => f.CreateDate)
                .FirstOrDefaultAsync();
            if(folderWithoutClass!= null){
                return folderWithoutClass;
            }
#pragma warning disable CS8603 // Possible null reference return.
            return folderWithClass;
#pragma warning restore CS8603 // Possible null reference return.
        }
        public async Task<Folder> Insert(Folder entity)
        {
            var Folder = await _context.Folder.AddAsync(entity);
            await Save();
            return Folder.Entity;
        }
        public async Task<Folder> Update(Folder entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<Folder> Delete(int Id)
        {
            var entity = await _context.Folder.FindAsync(Id);
            _context.Folder.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
        // Get all Folder user has userId created
        public async Task<IEnumerable<Folder>> GetByUserId(int userId)
        {
            var foldersWithClass = await _context.Folder
                .Where(f => f.UserId == userId && f.ClassId != null)
                .Include(f => f.User)
                .Include(f => f.Class)
                .OrderByDescending(f => f.CreateDate)
                .ToListAsync();

            // Get folders where ClassId is null and exclude Class
            var foldersWithoutClass = await _context.Folder
                .Where(f => f.UserId == userId && f.ClassId == null)
                .Include(f => f.User)
                .OrderByDescending(f => f.CreateDate)
                .ToListAsync();

            // Combine both results
            var allFolders = foldersWithClass.Concat(foldersWithoutClass).ToList();
            return allFolders;
        }

        public async Task<IEnumerable<Folder>> GetByClassId(int classId)
        {
            return await _context.Folder
                                        .Where(f => f.ClassId != null && f.ClassId == classId)
                                        .Include(f => f.User)
                                        .Include(f => f.Class)
                                        .OrderByDescending(f => f.CreateDate)
                                        .ToListAsync();
        }

        public async Task<IEnumerable<Folder>> GetByUserIdWithPage(int userId, int page, int limit)
        {
            var offset = (page - 1) * limit;

            var foldersWithClass = _context.Folder
                .Where(f => f.UserId == userId && f.ClassId != null)
                .Include(f => f.User)
                .Include(f => f.Class);

            // Get folders where ClassId is null and exclude Class
            var foldersWithoutClass = _context.Folder
                .Where(f => f.UserId == userId && f.ClassId == null)
                .Include(f => f.User);
            var combinedQuery = foldersWithClass.Union(foldersWithoutClass)
                .OrderByDescending(f => f.CreateDate);
            var pagedResult = await combinedQuery
                .Skip(offset)
                .Take(limit)
                .ToListAsync();

            return pagedResult;
        }

        public async Task<IEnumerable<Folder>> GetByClassIdWithPage(int classId, int page, int limit)
        {
            var offset = (page - 1) * limit;
            return await _context.Folder
                                .Where(f => f.ClassId != null && f.ClassId == classId)
                                .Include(f => f.User)
                                .Include(f => f.Class)
                                .OrderByDescending(e => e.CreateDate)
                                .Skip(offset)
                                .Take(limit)
                                .ToListAsync();
        }

        public async Task<int> CountOfPageFolderByUserId(int userId, int limit)
        {
            var totalRecords = await _context.Folder
                                .Where(f => f.UserId == userId)
                                .CountAsync();

            return (int)Math.Ceiling((double)totalRecords / limit);
        }

        public async Task<int> CountOfPageFolderByClassId(int classId, int limit)
        {
            var totalRecords = await _context.Folder
                                .Where(c => c.ClassId == classId)
                                .CountAsync();
            return (int)Math.Ceiling((double)totalRecords / limit);
        }
    }
}