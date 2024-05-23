using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class Member : IModel
    {
        public int Id { get; set;}
        public int UserId { get; set;}
        public int ClassId { get; set;}
        public virtual UserInfo User { get; set;}  
        public virtual Class Class { get; set;}
        
    }
}