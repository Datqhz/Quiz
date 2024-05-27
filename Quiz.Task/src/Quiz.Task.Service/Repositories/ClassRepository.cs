
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
            var data = await _context.Class
                                .Include(e => e.User)
                                .Include(e => e.Folders)
                                .Include(e => e.Members)
                                .OrderByDescending(e => e.CreateDate)
                                .ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<Class>> GetAll(string query)
        {
            var data = await _context.Class.ToListAsync();
            return data;
        }
        public async Task<Class> GetById(int id)
        {
#pragma warning disable CS8603 // Possible null reference return.
            return await _context.Class
                                .Include(e => e.User)
                                .Include(e => e.Folders)
                                .Include(e => e.Members)
                                .Where(e => e.Id == id)
                                .FirstOrDefaultAsync();
#pragma warning restore CS8603 // Possible null reference return.
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
            var query = from e_class in _context.Class
                    join member in _context.Member
                    on e_class.Id equals member.ClassId
                    where member.UserId.Equals(userId) // Thay đổi điều kiện theo yêu cầu của bạn
                    select new Class
                    {
                        Id = e_class.Id,
                        ClassName = e_class.ClassName,
                        Description = e_class.Description,
                        CreateDate = e_class.CreateDate,
                        User = e_class.User,
                        Folders = e_class.Folders,
                        Members = e_class.Members,
                    };

            return await query.OrderByDescending(e => e.CreateDate).ToListAsync();
        }

    }
}