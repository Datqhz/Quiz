using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IStudySetRepository : IRepository<StudySet>
    {
        Task<IEnumerable<StudySet>> GetByUserId(int userId);
        Task<IEnumerable<StudySet>> GetByFolderId(int folderId);
        Task<IEnumerable<StudySet>> GetByUserIdWithPage(int userId, int page, int limit);
        Task<IEnumerable<StudySet>> GetByFolderIdWithPage(int folderId, int page, int limit);
        Task<int> CountOfPageStudySetByUserId(int userId, int limit);
        Task<int> CountOfPageStudySetByFolderId(int folderId,  int limit);
        Task<IEnumerable<StudySet>> GetByRegex(int userId, string regex);
    }
}