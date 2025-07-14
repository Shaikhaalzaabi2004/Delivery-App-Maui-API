using DeliveryApi.Helper;
using DeliveryApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DeliveryAppAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        DeliveryDatabaseContext db = new DeliveryDatabaseContext();
        Authenticator authenticator = new Authenticator();

        [HttpGet]

        public ActionResult getProducts()
        {
            if (authenticator.authenticate(Request))
            {
                var products = db.Products.ToList();

                if (products != null)
                {
                    return Ok(products);
                }
                else
                {
                    return NotFound("No Products Found");
                }
            }
            else
            {
                return Unauthorized();
            }
        }
    }
}
