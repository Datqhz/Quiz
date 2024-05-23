using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IMemberRepository : IRepository<Member>
    {
        Task<IEnumerable<Member>> GetByUserId(int userId);
        Task<Member> DeleteByUserIdAndClassId(int userId, int classId);
        Task<IEnumerable<Member>> GetByClassId(int classId);
    }
}