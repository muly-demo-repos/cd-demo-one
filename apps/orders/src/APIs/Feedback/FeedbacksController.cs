using Microsoft.AspNetCore.Mvc;

namespace Orders.APIs;

[ApiController()]
public class FeedbacksController : FeedbacksControllerBase
{
    public FeedbacksController(IFeedbacksService service)
        : base(service) { }
}
