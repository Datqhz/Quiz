
using Microsoft.EntityFrameworkCore;
using Quiz.MyUser.Service.Models;

namespace Quiz.User.Service.DBContexts
{
    public class UserServiceContext : DbContext
    {
        public DbSet<Group> Group { get; set; }
        public DbSet<Account> Account { get; set; }
        public DbSet<UserInfo> User { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            string rootFolderPath = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.Parent.FullName, ".env");
            DotNetEnv.Env.Load(rootFolderPath);
            string ROOT_PASSWORD = Environment.GetEnvironmentVariable("DATABASE_ROOT_PASSWORD");
            optionsBuilder.UseMySQL("server=127.0.0.1;port=3308;database=UserService;user=root;password="+ROOT_PASSWORD);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Group>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Name).ValueGeneratedOnAdd();
                entity.Property(e => e.Name).IsRequired();
            });

            modelBuilder.Entity<Account>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.Email).IsRequired();
                entity.Property(e => e.Password).IsRequired();
            });
            modelBuilder.Entity<UserInfo>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.UserName).IsRequired();
                entity.Property(e => e.Image).IsRequired();
                entity.Property(e => e.CreateDate).HasDefaultValue<DateTime>(DateTime.UtcNow);
                entity.HasOne(e => e.Group)
                    .WithMany(g => g.Users)
                    .HasForeignKey(e => e.GroupId);
                entity.HasOne(e => e.Account)
                    .WithOne(a => a.User)
                    .HasForeignKey<UserInfo>(e => e.AccountId);

            });
        }
    }
}