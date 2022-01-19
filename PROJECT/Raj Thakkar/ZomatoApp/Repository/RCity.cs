using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{
    public class RCity : GenericRepository<City>, ICity
    {
        public RCity(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}
