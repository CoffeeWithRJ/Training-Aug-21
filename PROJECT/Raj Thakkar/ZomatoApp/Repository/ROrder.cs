using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{

    public class ROrder : GenericRepository<Ordertable>, IOrder
    {
        public ROrder(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}
