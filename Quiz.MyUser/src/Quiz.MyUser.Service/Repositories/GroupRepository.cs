using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.MyUser.Service.Models;
using Quiz.User.Service.DBContexts;

namespace Quiz.MyUser.Service.Repository
{
    public class GroupRepository : IRepository<Group>
    {
        
        private readonly UserServiceContext _context;
        public GroupRepository(UserServiceContext context)
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
        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}