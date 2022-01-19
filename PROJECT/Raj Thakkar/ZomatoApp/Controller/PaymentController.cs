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
    public class PaymentController : ControllerBase
    {
        private readonly ZomatoApp_ProjectContext context;
        IPayment Category;
        public PaymentController(IPayment custo, ZomatoApp_ProjectContext _context)
        {
            this.Category = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<Models.Payment> AddNewDataMethod()
        {
            return Category.GetAll();
        }


        // DELETE: api/Cosutomer/5
        [HttpDelete("{id}")]
        public string Deletes([FromBody] int id)
        {
            try
            {
                var dataDelete = context.Payments.Single(s => s.PaymentId == id);
                Category.Delete(dataDelete);
                return "Payment removed successfully";
            }
            catch (Exception)
            {
                return $"Payment not found...";
            }
        }
    }
}