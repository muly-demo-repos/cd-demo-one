using Orders.Infrastructure;

namespace Orders.APIs;

public class FeedbacksService : FeedbacksServiceBase
{
    public FeedbacksService(OrdersDbContext context)
        : base(context) { }
}
