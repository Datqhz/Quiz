using Quiz.MyUser.Service.Models;
using Quiz.User.Service.DBContexts;

namespace Quiz.MyUser.Service.Repository
{
    public class UserInfoRepository : IRepository<UserInfo>
    {
        private readonly UserServiceContext _context;
        public UserInfoRepository(UserServiceContext context)
        {
            this._context = context;
        }
        public IEnumerable<UserInfo> GetAll()
        {

        }
        public IEnumerable<UserInfo> GetAll(string query)
        {

        }
        public UserInfo Get(string query)
        {

        }
        public UserInfo Insert(UserInfo entity)
        {

        }
        public UserInfo Update(UserInfo entity)
        {

        }
        public UserInfo Delete(int Id)
        {

        }
        public void Save()
        {

        }
    }
}