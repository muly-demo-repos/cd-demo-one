using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Orders.Infrastructure.Models;

[Table("Feedbacks")]
public class FeedbackDbModel
{
    [StringLength(1000)]
    public string? Comments { get; set; }

    [Required()]
    public DateTime CreatedAt { get; set; }

    [StringLength(1000)]
    public string? Customer { get; set; }

    [Key()]
    [Required()]
    public string Id { get; set; }

    [Range(-999999999, 999999999)]
    public int? Rating { get; set; }

    [Required()]
    public DateTime UpdatedAt { get; set; }
}
