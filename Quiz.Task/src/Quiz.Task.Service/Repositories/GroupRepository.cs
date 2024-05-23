
using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repositories
{
    public class GroupRepository : IRepository<Group>
    {
        private readonly TaskServiceContext _context;
        public GroupRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Group>> GetAll()
        {
            var data = await _context.Group.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<Group>> GetAll(string query)
        {
            var data = await _context.Group.ToListAsync();
            return data;
        }
        public async Task<Group> GetById(int id)
        {
            return await _context.Group.FindAsync(id);
        }
        public async Task<Group> Insert(Group entity)
        {
            var group = await _context.Group.AddAsync(entity);
            await Save();
            return group.Entity;
        }
        public async Task<Group> Update(Group entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<Group> Delete(int Id)
        {
            var entity = await _context.Group.FindAsync(Id);
            _context.Group.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}