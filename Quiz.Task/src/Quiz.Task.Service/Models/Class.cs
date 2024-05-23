using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class Class : IModel
    {
        public int Id { get; set;}
        public string ClassName { get; set;}
        public DateTime CreateDate { get; set;}
        public string Description { get; set;}
        public int UserId { get; set;}
        public virtual UserInfo User { get; set;} 
        public virtual ICollection<Folder> Folders { get; set; }
        public virtual ICollection<Member> Members { get; set; }
        
    }
}