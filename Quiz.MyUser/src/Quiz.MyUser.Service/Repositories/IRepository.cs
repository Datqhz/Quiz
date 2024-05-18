using Quiz.MyUser.Service.Models;

namespace Quiz.MyUser.Service.Repository
{
    public interface IRepository<T> where T : IModel
    {
        IEnumerable<T> GetAll();
        IEnumerable<T> GetAll(string query);
        T Get(string query);
        T Insert(T entity);
        T Update(T entity);
        T Delete(int Id);
        void Save();
    }
}