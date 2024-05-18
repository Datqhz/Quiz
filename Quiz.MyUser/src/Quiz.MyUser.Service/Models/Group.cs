namespace Quiz.MyUser.Service.Models
{
    public class Group : IModel
    {
        public int Id { get; set;}
        public string Name { get; set;}
        public string Description { get; set;}
        public virtual ICollection<UserInfo> Users { get; set; }
    }
}