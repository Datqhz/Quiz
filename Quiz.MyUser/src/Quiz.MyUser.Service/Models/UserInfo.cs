namespace Quiz.MyUser.Service.Models
{
    public class UserInfo : IModel
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Image { get; set; } 
        public DateTime CreateDate { get; set; }

        public int AccountId { get; set; }

        public int GroupId { get; set; }

        public virtual Account Account { get; set; }
        public virtual Group Group { get; set; }
    }
}