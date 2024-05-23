
using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

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
            var data = await _context.StudySet.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<StudySet>> GetAll(string query)
        {
            var data = await _context.StudySet.ToListAsync();
            return data;
        }
        public async Task<StudySet> GetById(int id)
        {
            return await _context.StudySet.FindAsync(id);
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
            return await _context.StudySet.Where(c => c.UserId == userId).ToListAsync();

        }
    }
}