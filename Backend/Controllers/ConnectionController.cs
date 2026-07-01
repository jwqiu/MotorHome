using Microsoft.AspNetCore.Mvc;

namespace MotorHome.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ConnectionController : ControllerBase
{
    [HttpGet]
    public int Get()
    {
        return 1;
    }
}
