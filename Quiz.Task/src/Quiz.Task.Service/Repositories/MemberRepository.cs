
using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Repositories
{
    public class MemberRepository : IMemberRepository
    {
        private readonly TaskServiceContext _context;
        public MemberRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Member>> GetAll()
        {
            var data = await _context.Member.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<Member>> GetAll(string query)
        {
            var data = await _context.Member.ToListAsync();
            return data;
        }
        public async Task<Member> GetById(int id)
        {
            return await _context.Member.FindAsync(id);
        }
        public async Task<Member> Insert(Member entity)
        {
            var Member = await _context.Member.AddAsync(entity);
            await Save();
            return Member.Entity;
        }
        public async Task<Member> Update(Member entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<Member> Delete(int Id)
        {
            var entity = await _context.Member.FindAsync(Id);
            _context.Member.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<Member>> GetByUserId(int userId)
        {
            return await _context.Member.Where(c => c.UserId == userId).ToListAsync();

        }

        public async Task<Member> DeleteByUserIdAndClassId(int userId, int classId)
        {
            var entity = await _context.Member.Where(e => e.UserId == userId && e.ClassId == classId).FirstOrDefaultAsync();
            _context.Member.Remove(entity);
            await Save();
            return entity;
        }

        public async Task<IEnumerable<Member>> GetByClassId(int classId)
        {
            return await _context.Member.Where(c => c.ClassId == classId).ToListAsync();

        }
    }
}