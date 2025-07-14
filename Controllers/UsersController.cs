using DeliveryApi.Models;
using DeliveryApi.Helper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DeliveryAppAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        DeliveryDatabaseContext db = new DeliveryDatabaseContext();
        Authenticator authenticator = new Authenticator();

        [HttpPost]
        [Route("login")]

        public ActionResult login(LoginRequest loginRequest)
        {
            if (authenticator.authenticate(Request))
            {
                var validUer = db.Users.FirstOrDefault(x => x.Email == loginRequest.Email && x.PasswordHash == loginRequest.PasswordHash);

                if (validUer != null) {
                    return Ok(validUer);
                }
                else
                {
                    return NotFound("Invalid Credentials");
                }
            }
            else
            {
                return Unauthorized();
            }
        }

        [HttpPost]
        [Route("register")]

        public ActionResult register(User userToRegister)
        {
            if (authenticator.authenticate(Request))
            {
                db.Users.Add(userToRegister);
                db.SaveChanges();

                if (db.Users.Contains(userToRegister))
                {
                    return Ok(userToRegister);
                }
                else
                {
                    return NotFound("Could Not Register User");
                }
            }
            else
            {
                return Unauthorized();
            }
        }
    }
}
