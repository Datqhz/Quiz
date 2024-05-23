
using Microsoft.EntityFrameworkCore;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Repositories
{
    public class CardRepository : ICardRepository
    {
        private readonly TaskServiceContext _context;
        public CardRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Card>> GetAll()
        {
            var data = await _context.Card.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<Card>> GetAll(string query)
        {
            var data = await _context.Card.ToListAsync();
            return data;
        }
        public async Task<Card> GetById(int id)
        {
            return await _context.Card.FindAsync(id);
        }
        public async Task<Card> Insert(Card entity)
        {
            var Card = await _context.Card.AddAsync(entity);
            await Save();
            return Card.Entity;
        }
        public async Task<Card> Update(Card entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<Card> Delete(int Id)
        {
            var entity = await _context.Card.FindAsync(Id);
            _context.Card.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<Card>> GetByStudySetId(int studySetId)
        {
            return await _context.Card.Where(c => c.StudySetId == studySetId).ToListAsync();
        }
        public async Task<IEnumerable<Card>> DeleteByStudySetId(int studySetId)
        {
            var entities = await _context.Card.Where(c => c.StudySetId == studySetId).ToListAsync();
            
            foreach(var entity in entities)
            {
                _context.Card.Remove(entity);
            }
            await Save();
            return entities;
        }
    }
}