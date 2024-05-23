
using Microsoft.EntityFrameworkCore;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Repositories
{
    public class ClassRepository : IClassRepository
    {
        private readonly TaskServiceContext _context;
        public ClassRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Class>> GetAll()
        {
            var data = await _context.Class.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<Class>> GetAll(string query)
        {
            var data = await _context.Class.ToListAsync();
            return data;
        }
        public async Task<Class> GetById(int id)
        {
            return await _context.Class.FindAsync(id);
        }
        public async Task<Class> Insert(Class entity)
        {
            var Class = await _context.Class.AddAsync(entity);
            await Save();
            return Class.Entity;
        }
        public async Task<Class> Update(Class entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<Class> Delete(int Id)
        {
            var entity = await _context.Class.FindAsync(Id);
            _context.Class.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
        // Get all class user has userId created
        public async Task<IEnumerable<Class>> GetByUserId(int userId)
        {
            return await _context.Class.Where(c => c.UserId == userId).ToListAsync();
        }

    }
}