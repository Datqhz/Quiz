using Microsoft.EntityFrameworkCore;
using Quiz.MyUser.Service.Models;
using Quiz.User.Service.DBContexts;

namespace Quiz.MyUser.Service.Repository
{
    public class AccountRepository : IAccountRepository
    {
        
        private readonly UserServiceContext _context;
        public AccountRepository(UserServiceContext context)
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
        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }
    }
}