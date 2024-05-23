using Quiz.Common.Models;

namespace  Quiz.Task.Service.Models
{
    public class FolderDetail : IModel
    {
        public int Id { get; set; }
        public int FolderId { get; set; }
        public int StudySetId { get; set; }
        public virtual Folder Folder { get; set; }
        public virtual StudySet StudySet { get; set; }
    }
}