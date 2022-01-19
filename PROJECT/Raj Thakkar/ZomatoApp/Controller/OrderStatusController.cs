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
    public class OrderStatusController : ControllerBase
    {
        private readonly ZomatoApp_ProjectContext context;
        IOrderStatus Category;
        public OrderStatusController(IOrderStatus custo, ZomatoApp_ProjectContext _context)
        {
            this.Category = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<Models.OrderStatus> AddNewDataMethod()
        {
            return Category.GetAll();
        }


        [HttpPost]
        public string creates([FromBody] OrderStatus obEntity)
        {

            OrderStatus check = context.OrderStatuses.FirstOrDefault(s => s.Orderstatusid == obEntity.Orderstatusid);
            if (check != null)
                //new Exception("Create already exists...");
                return "OrderStatus already exists...";
            else
            {
                Category.Create(obEntity);
                OrderStatus ObjEntity = context.OrderStatuses.ToList().Last();
                return $"OrderStatus {ObjEntity.Orderstatusid} is added successfully and your id is {ObjEntity}";
            }
        }


        // DELETE: api/Cosutomer/5
        [HttpDelete("{id}")]
        public string Deletes([FromBody] int id)
        {
            try
            {
                var dataDelete = context.OrderStatuses.Single(s => s.Orderstatusid == id);
                Category.Delete(dataDelete);
                return "OrderStatus removed successfully";
            }
            catch (Exception)
            {
                return $"OrderStatus not found...";
            }
        }
    }
}
