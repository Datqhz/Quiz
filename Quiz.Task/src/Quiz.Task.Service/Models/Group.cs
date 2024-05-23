using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class Group : IModel
    {
        public int Id { get; set;}
        public string Name { get; set;}
        public virtual ICollection<UserInfo> Users { get; set; }
    }
}