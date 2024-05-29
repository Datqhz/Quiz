using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Quiz.Common.Responses;

namespace Quiz.Common.Middleware
{
    public class ErrorHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        public ErrorHandlingMiddleware(RequestDelegate next)
        {
            _next = next;
        }
        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"error: {ex.Message}");
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                context.Response.ContentType = "application/json";
                var customErrorResponse = new ResponseModel<string>
                {
                    EC = 500,
                    EM = "Internal Server Error!",
                    DT = ""
                };
                //Log the Exception Details
                var responseJson = JsonSerializer.Serialize(customErrorResponse);
                await context.Response.WriteAsync(responseJson);
            }
        }
    }
}