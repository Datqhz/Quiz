using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IFolderRepository : IRepository<Folder>
    {
        Task<IEnumerable<Folder>> GetByUserId(int userId);
        Task<IEnumerable<Folder>> GetByUserIdAndNotInClass(int userId);
        Task<IEnumerable<Folder>> GetByUserIdAndNotContainStudySet(int userId, int studySetId);
        Task<IEnumerable<Folder>> GetByClassId(int classId);
        Task<IEnumerable<Folder>> GetByUserIdWithPage(int userId, int page, int limit);
        Task<IEnumerable<Folder>> GetByClassIdWithPage(int classId, int page, int limit);
        Task<int> CountOfPageFolderByUserId(int userId, int limit);
        Task<int> CountOfPageFolderByClassId(int classId, int limit);
    }
}