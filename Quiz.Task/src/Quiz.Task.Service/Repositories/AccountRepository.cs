using Microsoft.EntityFrameworkCore;
using Quiz.Common.Repository;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;

namespace Quiz.MyUser.Service.Repository
{
    public class AccountRepository : IRepository<Account>
    {
        
        private readonly TaskServiceContext _context;
        public AccountRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<Account>> GetAll()
        {
            var data = await _context.Account.ToListAsync();
            return data; 
        }   
        public async Task<IEnumerable<Account>> GetAll(string query)
        {
            var data = await _context.Account.ToListAsync();
            return data;
        }
        public async Task<Account> GetById(int id)
        {
            return await _context.Account.FindAsync(id);
        }
        public async Task<Account> GetByEmail(string email)
        {
            var data = await _context.Account
                                .Include(a => a.User)
                                .FirstOrDefaultAsync(a => a.Email == email);
            return data;
        }
        public async Task<Account> Insert(Account entity)
        {
            var account = await _context.Account.AddAsync(entity);
            await Save();
            return account.Entity;
        }
        public async Task<Account> Update(Account entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        } 
        public async Task<Account> Delete(int Id)
        {
            var entity = _context.Account.Find(Id);
            _context.Account.Remove(entity);
            await Save();
            return entity;
        }
        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}