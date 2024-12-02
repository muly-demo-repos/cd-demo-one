using Microsoft.EntityFrameworkCore;
using Orders.Infrastructure.Models;

namespace Orders.Infrastructure;

public class OrdersDbContext : DbContext
{
    public OrdersDbContext(DbContextOptions<OrdersDbContext> options)
        : base(options) { }

    public DbSet<FeedbackDbModel> Feedbacks { get; set; }
}
