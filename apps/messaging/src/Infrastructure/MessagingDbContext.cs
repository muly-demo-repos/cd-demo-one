using Microsoft.EntityFrameworkCore;

namespace Messaging.Infrastructure;

public class MessagingDbContext : DbContext
{
    public MessagingDbContext(DbContextOptions<MessagingDbContext> options)
        : base(options) { }
}
