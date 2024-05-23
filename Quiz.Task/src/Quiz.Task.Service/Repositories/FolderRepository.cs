
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
            return await _context.Folder.FindAsync(id);
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
            return await _context.Folder.Where(c => c.UserId == userId).ToListAsync();
        }

        public async Task<IEnumerable<Folder>> GetByClassId(int classId)
        {
            return await _context.Folder.Where(c => c.ClassId == classId).ToListAsync();

        }
    }
}