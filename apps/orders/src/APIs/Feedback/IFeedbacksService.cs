using Orders.APIs.Common;
using Orders.APIs.Dtos;

namespace Orders.APIs;

public interface IFeedbacksService
{
    /// <summary>
    /// Create one Feedback
    /// </summary>
    public Task<Feedback> CreateFeedback(FeedbackCreateInput feedback);

    /// <summary>
    /// Delete one Feedback
    /// </summary>
    public Task DeleteFeedback(FeedbackWhereUniqueInput uniqueId);

    /// <summary>
    /// Find many Feedbacks
    /// </summary>
    public Task<List<Feedback>> Feedbacks(FeedbackFindManyArgs findManyArgs);

    /// <summary>
    /// Meta data about Feedback records
    /// </summary>
    public Task<MetadataDto> FeedbacksMeta(FeedbackFindManyArgs findManyArgs);

    /// <summary>
    /// Get one Feedback
    /// </summary>
    public Task<Feedback> Feedback(FeedbackWhereUniqueInput uniqueId);

    /// <summary>
    /// Update one Feedback
    /// </summary>
    public Task UpdateFeedback(FeedbackWhereUniqueInput uniqueId, FeedbackUpdateInput updateDto);
}
