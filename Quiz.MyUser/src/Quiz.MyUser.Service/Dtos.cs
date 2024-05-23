namespace Quiz.MyUser.Service.Dtos
{
    public record CreateAccountDto(string Email, string Password, string Username, int GroupId);
    public record UpdateAccountDto(int Id, string Email, string Password);
    public record LoginDto(string Email, string Password);
    public record UpdateUserDto(int Id, string Username, string Image);
    public record CreateGroupDto(string Name, string Description);
}