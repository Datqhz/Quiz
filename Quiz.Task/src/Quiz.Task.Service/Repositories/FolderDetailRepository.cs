
using Microsoft.EntityFrameworkCore;
using Quiz.Task.Service.DBContexts;
using Quiz.Task.Service.Models;
using Quiz.Task.Service.Repository;

namespace Quiz.Task.Service.Repositories
{
    public class FolderDetailRepository : IFolderDetailRepository
    {
        private readonly TaskServiceContext _context;
        public FolderDetailRepository(TaskServiceContext context)
        {
            this._context = context;
        }
        public async Task<IEnumerable<FolderDetail>> GetAll()
        {
            var data = await _context.FolderDetail.ToListAsync();
            return data;
        }   
        public async Task<IEnumerable<FolderDetail>> GetAll(string query)
        {
            var data = await _context.FolderDetail.ToListAsync();
            return data;
        }
        public async Task<FolderDetail> GetById(int id)
        {
            return await _context.FolderDetail.FindAsync(id);
        }
        public async Task<FolderDetail> Insert(FolderDetail entity)
        {
            var FolderDetail = await _context.FolderDetail.AddAsync(entity);
            await Save();
            return FolderDetail.Entity;
        }
        public async Task<FolderDetail> Update(FolderDetail entity)
        {
            _context.Entry(entity).State = EntityState.Modified;
            await Save();
            return _context.Entry(entity).Entity;
        }
        public async Task<FolderDetail> Delete(int Id)
        {
            var entity = await _context.FolderDetail.FindAsync(Id);
            _context.FolderDetail.Remove(entity);
            await Save();
            return entity;
        }

        public async System.Threading.Tasks.Task Save()
        {
            await _context.SaveChangesAsync();
        }
        public async Task<IEnumerable<FolderDetail>> GetByFolderId(int folderId)
        {
            return await _context.FolderDetail.Where(c => c.FolderId == folderId).ToListAsync();

        }
    }
}