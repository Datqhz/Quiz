using Quiz.Common.Repository;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.Repository
{
    public interface IFolderDetailRepository : IRepository<FolderDetail>
    {
        Task<IEnumerable<FolderDetail>> GetByFolderId(int folderId);
    }
}