namespace Quiz.MysUser.Service.ResponseDtos
{
    public record UserDto(int Id, string UserName, DateTime CreateDate, byte[] Image, string GroupName);
    public record AccountDto(int Id, string Email, UserDto User);
    public record LoginResult(int UserId, string UserName, string Email, string Token, string GroupName);
}