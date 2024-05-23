using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IStudySetRepository : IRepository<StudySet>
    {
        Task<IEnumerable<StudySet>> GetByUserId(int userId);
    }
}