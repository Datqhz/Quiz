using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;

namespace Quiz.MyUser.Service.Repository
{
    public class UserInfoRepository : IRepository<UserInfo>
    {
        private readonly TaskServiceContext _context;
        public UserInfoRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<UserInfo>> GetAll()
        {
            var data = await _context.User.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<UserInfo>> GetAll(string query)
        {
            var data = await _context.User.ToListAsync();
            return data;
        }
        public async Task<UserInfo> GetById(int id)
        {
            return await _context.User.FindAsync(id);
        }
        public async Task<UserInfo> Insert(UserInfo entity)
        {
            var user = await _context.User.AddAsync(entity);
            await Save();
            return user.Entity;
        }
        public async Task<UserInfo> Update(UserInfo entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<UserInfo> Delete(int Id)
        {
            var entity = await _context.User.FindAsync(Id);
            _context.User.Remove(entity);
            await Save();
            return entity;
        }
        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}