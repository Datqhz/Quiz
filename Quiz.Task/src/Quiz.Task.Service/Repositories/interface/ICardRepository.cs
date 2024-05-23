using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface ICardRepository : IRepository<Card>
    {
        Task<IEnumerable<Card>> GetByStudySetId(int studySetId);
        Task<IEnumerable<Card>> DeleteByStudySetId(int studySetId);
    }
}