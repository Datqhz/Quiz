using Quiz.Common.Models;

namespace Quiz.MyUser.Service.Models
{
    public class Account : IModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public virtual UserInfo User { get; set; }
    }
}