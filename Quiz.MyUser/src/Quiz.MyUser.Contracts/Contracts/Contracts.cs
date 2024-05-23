namespace Quiz.MyUser.Contract
{
        public record AccountCreated(int Id, string Email, string Password);
        public record AccountUpdated(int Id, string Email, string Password);
        public record UserCreated(int Id, string UserName, string Image, DateTime CreatedDate, int AccountId, int GroupId);
        public record UserUpdated(int Id, string UserName, string Image);
        public record GroupCreated(int Id, string GroupName);
}