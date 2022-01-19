using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{

    public class RProduct : GenericRepository<Product>, IProduct
    {
        public RProduct(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}
