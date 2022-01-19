using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{
    public class RRestaurant : GenericRepository<Restaurant>, IRestaurant
    {
        public RRestaurant(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}
