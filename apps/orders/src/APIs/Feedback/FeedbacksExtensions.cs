using Orders.APIs.Dtos;
using Orders.Infrastructure.Models;

namespace Orders.APIs.Extensions;

public static class FeedbacksExtensions
{
    public static Feedback ToDto(this FeedbackDbModel model)
    {
        return new Feedback
        {
            Comments = model.Comments,
            CreatedAt = model.CreatedAt,
            Customer = model.Customer,
            Id = model.Id,
            Rating = model.Rating,
            UpdatedAt = model.UpdatedAt,
        };
    }

    public static FeedbackDbModel ToModel(
        this FeedbackUpdateInput updateDto,
        FeedbackWhereUniqueInput uniqueId
    )
    {
        var feedback = new FeedbackDbModel
        {
            Id = uniqueId.Id,
            Comments = updateDto.Comments,
            Customer = updateDto.Customer,
            Rating = updateDto.Rating
        };

        if (updateDto.CreatedAt != null)
        {
            feedback.CreatedAt = updateDto.CreatedAt.Value;
        }
        if (updateDto.UpdatedAt != null)
        {
            feedback.UpdatedAt = updateDto.UpdatedAt.Value;
        }

        return feedback;
    }
}
