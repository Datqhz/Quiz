using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using Quiz.Common.Repository;
using Quiz.MyUser.Service.Models;
using Quiz.User.Service.DBContexts;

namespace Quiz.MyUser.Service.Repository
{
    public class UserInfoRepository : IUserInfoRepository
    {
        private readonly UserServiceContext _context;
        public UserInfoRepository(UserServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<UserInfo>> GetAll()
        {
            var data = await _context.User
                                    .Select(e => new UserInfo
                                    {
                                        Id = e.Id,
                                        UserName = e.UserName,
                                        CreateDate = e.CreateDate,
                                        Image = e.Image,
                                        Account = new Account
                                        {
                                            Id = e.Account.Id,
                                            Email = e.Account.Email,
                                        },
                                        Group = new Group
                                        {
                                            Id = e.Group.Id,
                                            Name = e.Group.Name,
                                        }
                                    })
                                    .ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<UserInfo>> GetAll(string query)
        {
            var data = await _context.User
            .ToListAsync();
            return data;
        }
        public async Task<UserInfo> GetById(int id)
        {
#pragma warning disable CS8603 // Possible null reference return.
            return await _context.User
                                .Select(e => new UserInfo
                                {
                                    Id = e.Id,
                                    UserName = e.UserName,
                                    CreateDate = e.CreateDate,
                                    Image = e.Image,
                                    Account = new Account
                                    {
                                        Id = e.Account.Id,
                                        Email = e.Account.Email,
                                    },
                                    Group = new Group
                                    {
                                        Id = e.Group.Id,
                                        Name = e.Group.Name,
                                    }
                                })
                                .Where(e => e.Id == id)
                                .FirstOrDefaultAsync();
#pragma warning restore CS8603 // Possible null reference return.
        }
        public async Task<UserInfo> Insert(UserInfo entity)
        {
            var user = await _context.User.AddAsync(entity);
            await Save();
            return user.Entity;
        }
        public async Task<UserInfo> Update(UserInfo entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<UserInfo> Delete(int Id)
        {
            var entity = await _context.User.FindAsync(Id);
            _context.User.Remove(entity);
            await Save();
            return entity;
        }
        public async Task Save()
        {
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<UserInfo>> FindByRegex(string regex)
        {
#pragma warning disable CS8603 // Possible null reference return.
            return await _context.User
                                .FromSqlRaw("SELECT * FROM User WHERE UserName REGEXP {0}", regex)
                                .Select(e => new UserInfo
                                {
                                    Id = e.Id,
                                    UserName = e.UserName,
                                    CreateDate = e.CreateDate,
                                    Image = e.Image,
                                    Account = new Account
                                    {
                                        Id = e.Account.Id,
                                        Email = e.Account.Email,
                                    },
                                    Group = new Group
                                    {
                                        Id = e.Group.Id,
                                        Name = e.Group.Name,
                                    }
                                })
                                .ToListAsync();
#pragma warning restore CS8603 // Possible null reference return.
        }
    }
}