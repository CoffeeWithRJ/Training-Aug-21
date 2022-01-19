using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{
    public class RCart : GenericRepository<Cart>, ICart
    {
            public RCart(ZomatoApp_ProjectContext context) : base(context)
            {

            }
        
    }
}
