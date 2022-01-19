using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ZomatoApp.Models;
using ZomatoApp.Repository.Interfaces;

namespace ZomatoApp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserSignupsController : ControllerBase
    {
        
        private readonly ZomatoApp_ProjectContext context;
        IUserSignup UserSignup;
        public UserSignupsController(IUserSignup custo, ZomatoApp_ProjectContext _context)
        {
            this.UserSignup = custo;
            this.context = _context;
        }

        [HttpGet]
        public IEnumerable<UserSignup> AddUserMethod()
        {
            return UserSignup.GetAll();
        }


        [HttpPost]
        public string creates([FromBody] UserSignup addUser)
        {

            UserSignup checkuser = context.UserSignups.FirstOrDefault(s => s.Phoneno == addUser.Phoneno);
            if (checkuser != null)
                //new Exception("Create already exists...");
                return "User already exists...";
            else
            {
                UserSignup.Create(addUser);
                UserSignup addedUser = context.UserSignups.ToList().Last();
                return $"UserSingup {addedUser.Names} is added successfully and your id is {addedUser.UserId}";
            }
        }

        [HttpGet("{id}")]
        public ActionResult<UserSignup> GetUserSignups(int id)
        {
            var userSignup = UserSignup.GetById(id);

            if (userSignup == null)
            {
                return NotFound();
            }
            return userSignup;
        }
        [HttpDelete("{id}")]
        public IActionResult DeleteUserSignup(int id)
        {
            var userSignup = UserSignup.GetById(id);
            if (userSignup == null)
            {
                return NotFound();
            }

            UserSignup.Delete(userSignup);

            return NoContent();
        }

        //Put

        [HttpPut("{id}")]
        public ActionResult<UserSignup> PutUserSignup(int id, UserSignup userSignup)
        {
            try
            {
                UserSignup.Update(userSignup);
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            return GetUserSignups(id);

        }
    }
}
