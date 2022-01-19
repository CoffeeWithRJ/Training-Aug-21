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
    public class ViewProductController : ControllerBase
    {
        private readonly ZomatoApp_ProjectContext context;
        IViewProduct Category;
        public ViewProductController(IViewProduct custo, ZomatoApp_ProjectContext _context)
        {
            this.Category = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<Models.ViewProduct> AddNewDataMethod()
        {
            return Category.GetAll();
        }

            }
}
