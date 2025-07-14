using DeliveryApi.Models;
using DeliveryApi.Helper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DeliveryAppAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        DeliveryDatabaseContext db = new DeliveryDatabaseContext();
        Authenticator authenticator = new Authenticator();

        [HttpPost]

        public ActionResult addOrder(Order orderToAdd)
        {
            if (authenticator.authenticate(Request))
            {
               
                db.Orders.Add(orderToAdd);
                db.SaveChanges();

                if (db.Orders.Contains(orderToAdd))
                {
                    return Ok("Order Placed");
                }
                else
                {
                    return NotFound("Could Not Place Order");
                }
            }
            else
            {
                return Unauthorized();
            }
        }
    }
}
