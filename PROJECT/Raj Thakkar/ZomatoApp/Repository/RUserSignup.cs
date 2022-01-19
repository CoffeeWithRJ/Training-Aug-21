using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{
    public class RUserSignup : GenericRepository<UserSignup>, IUserSignup
    {
        public RUserSignup(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}
