using Microsoft.EntityFrameworkCore;
using Quiz.Task.Service.Models;

namespace Quiz.Task.Service.DBContexts
{
    public class TaskServiceContext : DbContext
    {
        public DbSet<Group> Group { get; set; }
        public DbSet<Account> Account { get; set; }
        public DbSet<UserInfo> User { get; set; }
        public DbSet<Card> Card { get; set; }
        public DbSet<Class> Class { get; set; }
        public DbSet<Folder> Folder { get; set; }
        public DbSet<FolderDetail> FolderDetail { get; set; }
        public DbSet<Member> Member { get; set; }
        public DbSet<StudySet> StudySet { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                string ROOT_PASSWORD = Environment.GetEnvironmentVariable("DATABASE_ROOT_PASSWORD");
                optionsBuilder.UseMySQL($"server=quiz-mysql;port=3306;database=TaskService;user=root;password={ROOT_PASSWORD}");
                optionsBuilder.EnableSensitiveDataLogging(true);
            }
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
                entity.Property(e => e.CreateDate).HasDefaultValueSql("CURRENT_TIMESTAMP(6)");
                entity.HasOne(e => e.Group)
                    .WithMany(g => g.Users)
                    .HasForeignKey(e => e.GroupId);
                entity.HasOne(e => e.Account)
                    .WithOne(a => a.User)
                    .HasForeignKey<UserInfo>(e => e.AccountId);
            });
            modelBuilder.Entity<Card>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.Term).IsRequired();
                entity.Property(e => e.Definition).IsRequired();
                entity.Property(e => e.StudySetId).IsRequired();
                entity.HasOne(e => e.StudySet)
                    .WithMany(g => g.Cards)
                    .HasForeignKey(e => e.StudySetId);
            });
            modelBuilder.Entity<Class>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.ClassName).IsRequired();
                entity.Property(e => e.UserId).IsRequired();
                entity.Property(e => e.CreateDate).HasDefaultValueSql("CURRENT_TIMESTAMP(6)");
                entity.HasOne(e => e.User)
                    .WithMany(u => u.Classes)
                    .HasForeignKey(e => e.UserId);
            });
            modelBuilder.Entity<Folder>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.FolderName).IsRequired();
                entity.Property(e => e.UserId).IsRequired();
                entity.Property(e => e.ClassId).IsRequired(false);
                entity.Property(e => e.CreateDate).HasDefaultValueSql("CURRENT_TIMESTAMP(6)");
                entity.HasOne(e => e.User)
                    .WithMany(u => u.Folders)
                    .HasForeignKey(e => e.UserId);
                entity.HasOne(e => e.Class)
                    .WithMany(u => u.Folders)
                    .HasForeignKey(e => e.ClassId)
                    .OnDelete(DeleteBehavior.SetNull);
            });
            modelBuilder.Entity<FolderDetail>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.StudySetId).IsRequired();
                entity.Property(e => e.FolderId).IsRequired();
                entity.HasOne(e => e.StudySet)
                    .WithMany(u => u.FolderDetails)
                    .HasForeignKey(e => e.StudySetId);
                entity.HasOne(e => e.Folder)
                    .WithMany(u => u.FolderDetails)
                    .HasForeignKey(e => e.FolderId);
            });
            modelBuilder.Entity<Member>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.UserId).IsRequired();
                entity.Property(e => e.ClassId).IsRequired();
                entity.HasOne(e => e.User)
                    .WithMany(u => u.Members)
                    .HasForeignKey(e => e.UserId);
                entity.HasOne(e => e.Class)
                    .WithMany(u => u.Members)
                    .HasForeignKey(e => e.ClassId);
            });
            modelBuilder.Entity<StudySet>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.UserId).IsRequired();
                entity.Property(e => e.StudySetName).IsRequired();
                entity.Property(e => e.CreateDate).HasDefaultValueSql("CURRENT_TIMESTAMP(6)");
                entity.HasOne(e => e.User)
                    .WithMany(u => u.StudySets)
                    .HasForeignKey(e => e.UserId);
            });
        }
    }
}