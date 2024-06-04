using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IClassRepository : IRepository<Class>
    {
        Task<IEnumerable<Class>> GetByUserId(int userId);
        Task<IEnumerable<Class>> GetByOwnerId(int userId);
        Task<IEnumerable<Class>> GetByUserIdWithPage(int userId, int page, int limit);
        Task<int> CountOfPageClassByUserId(int userId, int limit);
    }
}