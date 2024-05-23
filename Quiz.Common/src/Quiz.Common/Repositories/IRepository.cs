using Quiz.Common.Models;

namespace Quiz.Common.Repository
{
    public interface IRepository<T> where T : IModel
    {
        Task<IEnumerable<T>> GetAll();
        Task<IEnumerable<T>> GetAll(string query);
        Task<T> GetById(int id);
        Task<T> Insert(T entity);
        Task<T> Update(T entity);
        Task<T> Delete(int Id);
        Task Save();
    }
}