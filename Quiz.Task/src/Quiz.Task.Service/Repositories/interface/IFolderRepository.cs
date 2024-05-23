using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IFolderRepository : IRepository<Folder>
    {
        Task<IEnumerable<Folder>> GetByUserId(int userId);
        Task<IEnumerable<Folder>> GetByClassId(int classId);
    }
}