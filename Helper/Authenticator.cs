using System.Net.WebSockets;
using System.Text;

namespace DeliveryApi.Helper
{
    public class Authenticator
    {
        public bool authenticate(HttpRequest request)
        {
            if (!request.Headers.ContainsKey("Authorization"))
                return false;

            var header = request.Headers.Authorization.ToString();
            var encodedCredentials = header.Replace("Basic ", "", StringComparison.OrdinalIgnoreCase);
            var creadentials = Encoding.UTF8.GetString(Convert.FromBase64String(encodedCredentials)).Split(":");

            if (creadentials[0] == "staff" && creadentials[1] == "password")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
