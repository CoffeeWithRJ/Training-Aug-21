﻿using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ZomatoApp.Models;

namespace ZomatoApp.Repository
{

    public class ROrderStatus : GenericRepository<OrderStatus>, IOrderStatus
    {
        public ROrderStatus(ZomatoApp_ProjectContext context) : base(context)
        {

        }
    }
}