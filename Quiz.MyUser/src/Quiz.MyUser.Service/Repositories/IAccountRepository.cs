using Quiz.Common.Repository;
using Quiz.MyUser.Service.Models;

namespace Quiz.MyUser.Service.Repository
{
    public interface IAccountRepository : IRepository<Account>
    {
        Task<Account> GetByEmail(string email);
    }
}