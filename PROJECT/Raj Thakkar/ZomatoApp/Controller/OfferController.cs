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
    public class OfferController : ControllerBase
    {
        private readonly ZomatoApp_ProjectContext context;
        IOffer Offer;
        public OfferController(IOffer custo, ZomatoApp_ProjectContext _context)
        {
            this.Offer = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<Offer> AddNewOfferDataMethod()
        {
            return Offer.GetAll();
        }

        [HttpPost]
        public string creates([FromBody] Offer addOffer)
        {

            Offer check = context.Offers.FirstOrDefault(s=>s.OfferId  == addOffer.OfferId);
            if (check != null)
                //new Exception("Create already exists...");
                return "Customer already exists...";
            else
            {
                Offer.Create(addOffer);
                Offer addedOffer = context.Offers.ToList().Last();
                return $"Doctor {addedOffer.OfferId} is added successfully and your id is ";
            }
        }
    }
}
