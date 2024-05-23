using Quiz.Common.Models;

namespace Quiz.Task.Service.Models
{
    public class Card : IModel
    {
        public int Id { get; set;}
        public string Term { get; set;}
        public string Definition {get; set;}
        public int StudySetId { get; set;}
        public virtual StudySet StudySet{ get; set;}
    }
}