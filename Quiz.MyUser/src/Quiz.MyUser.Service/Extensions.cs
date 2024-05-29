using Quiz.MysUser.Service.ResponseDtos;
using Quiz.MyUser.Service.Models;

namespace Quiz.MyUser.Service.Extensions
{
    public static class Extension
    {
        public static UserDto AsDto(this UserInfo userInfo)
        {
            return new UserDto
            (
                userInfo.Id,
                userInfo.UserName,
                userInfo.CreateDate,
                userInfo.Image,
                userInfo.Group?.Name
            );
        }
        public static AccountDto AsDto(this Account account)
        {
            return new AccountDto
            (
                account.Id,
                account.Email,
                account.User.AsDto()
            );
        }
    }
}