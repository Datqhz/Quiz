using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class Folder : IModel
    {
        public int Id { get; set; }
        public string FolderName { get; set; } 
        public DateTime CreateDate { get; set; }
        public int UserId { get; set; }
        public int ClassId { get; set; }
        public virtual UserInfo User { get; set; }
        public virtual Class Class { get; set; }
        public virtual ICollection<FolderDetail> FolderDetails { get; set; }
    
    }    
}