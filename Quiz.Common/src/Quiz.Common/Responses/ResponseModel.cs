namespace Quiz.Common.Responses
{
    public class ResponseModel<T>
    {
        public int EC { get; set; } 
        public string EM { get; set; }
        public T DT { get; set; }
    }
}