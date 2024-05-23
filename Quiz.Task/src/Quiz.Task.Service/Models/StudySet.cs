using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class StudySet : IModel
    {
        public int Id { get; set; }
        public string StudySetName { get; set; }
        public DateTime CreateDate { get; set; }
        public int UserId { get; set; }
        public virtual UserInfo User { get; set; }
        public virtual ICollection<Card> Cards { get; set; }
        public virtual ICollection<FolderDetail> FolderDetails { get; set; }
        
    }
}