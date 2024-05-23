using System.Buffers.Text;
using System.Reflection.Metadata;
using Org.BouncyCastle.Utilities.Encoders;
using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class UserInfo : IModel
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public byte[] Image { get; set; } 
        public DateTime CreateDate { get; set; }

        public int AccountId { get; set; }

        public int GroupId { get; set; }

        public virtual Account Account { get; set; }
        public virtual Group Group { get; set; }
        public virtual ICollection<Folder> Folders { get; set; }
        public virtual ICollection<Class> Classes { get; set; }
        public virtual ICollection<Member> Members { get; set; }
        public virtual ICollection<StudySet> StudySets { get; set; }
        
        
    }
}