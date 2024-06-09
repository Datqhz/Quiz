using Quiz.Common.Repository;
using Quiz.MyUser.Service.Models;

namespace Quiz.MyUser.Service.Repository
{
    public interface IUserInfoRepository : IRepository<UserInfo>
    {
        Task<IEnumerable<UserInfo>> FindByRegex(string regex);
    }
}