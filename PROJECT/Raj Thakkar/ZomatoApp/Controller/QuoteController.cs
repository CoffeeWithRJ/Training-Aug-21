using Microsoft.AspNetCore.Mvc;
using ZomatoApp.Models;
using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ZomatoApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuoteController : ControllerBase
    {
        private readonly ZomatoApp_ProjectContext context;
        IQuote Category;
        public QuoteController(IQuote custo, ZomatoApp_ProjectContext _context)
        {
            this.Category = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<Models.Quote> AddNewDataMethod()
        {
            return Category.GetAll();
        }


        // DELETE: api/Cosutomer/5
        [HttpDelete("{id}")]
        public string Deletes([FromBody] int id)
        {
            try
            {
                var dataDelete = context.Quotes.Single(s => s.QuoteId == id);
                Category.Delete(dataDelete);
                return "Quote removed successfully";
            }
            catch (Exception)
            {
                return $"Quote not found...";
            }
        }
    }
}
