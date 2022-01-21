using Microsoft.AspNetCore.Mvc;
using ZomatoApp.Models;
using ZomatoApp.Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using ZomatoApp.DBContext;

namespace ZomatoApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RestaurantController : ControllerBase
    {

       
        private readonly IRestaurant Restaurant;
        public RestaurantController(IRestaurant rest)
        {
            Restaurant = rest;
            
        }
        //get all restaurant
        [HttpGet]
        public IEnumerable<Restaurant> GetRestorents()
        {
            return Restaurant.GetAll();
        }

        //Add reastaurant
        [HttpPost]
        public string creates([FromBody] Restaurant addUser)
        {

            Restaurant checkRestaurant = Restaurant.FirstOrDefault(s => s.RestaurantName == addUser.RestaurantName && s.RestaurantCity == addUser.RestaurantCity);
            if (checkRestaurant != null)
                
                return "Restaurant already exists...";
            else
            {
                Restaurant.Create(addUser);
                Restaurant addedUser = Restaurant.GetAll().Last();
                return $"Restaurant {addedUser.RestaurantName} is added successfully and your id is {addedUser.RestaurantId}";
            }
        }

        //Get By Id
        [HttpGet("{id}")]
        public ActionResult<Restaurant> GetRestaurents(int id)
        {
            var restaurent = Restaurant.GetById(id);

            if (restaurent == null)
            {
                return NotFound();
            }
            return restaurent;
        }

        //delete 
        [HttpDelete("{id}")]
        public IActionResult DeleteRestaurant(int id)
        {
            var restaurant = Restaurant.GetById(id);
            if (restaurant == null)
            {
                return NotFound();
            }

            Restaurant.Delete(restaurant);

            return NoContent();
        }

        //Put
        [HttpPut("{id}")]
        public ActionResult<Restaurant> PutRestaurent(int id, Restaurant restaurant)
        {
            try
            {
                Restaurant.Update(restaurant);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            return GetRestaurents(id);

        }
    }
}
