using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IClassRepository : IRepository<Class>
    {
        Task<IEnumerable<Class>> GetByUserId(int userId);
    }
}