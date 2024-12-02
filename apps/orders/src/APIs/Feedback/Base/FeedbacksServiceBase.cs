using Microsoft.EntityFrameworkCore;
using Orders.APIs;
using Orders.APIs.Common;
using Orders.APIs.Dtos;
using Orders.APIs.Errors;
using Orders.APIs.Extensions;
using Orders.Infrastructure;
using Orders.Infrastructure.Models;

namespace Orders.APIs;

public abstract class FeedbacksServiceBase : IFeedbacksService
{
    protected readonly OrdersDbContext _context;

    public FeedbacksServiceBase(OrdersDbContext context)
    {
        _context = context;
    }

    /// <summary>
    /// Create one Feedback
    /// </summary>
    public async Task<Feedback> CreateFeedback(FeedbackCreateInput createDto)
    {
        var feedback = new FeedbackDbModel
        {
            Comments = createDto.Comments,
            CreatedAt = createDto.CreatedAt,
            Customer = createDto.Customer,
            Rating = createDto.Rating,
            UpdatedAt = createDto.UpdatedAt
        };

        if (createDto.Id != null)
        {
            feedback.Id = createDto.Id;
        }

        _context.Feedbacks.Add(feedback);
        await _context.SaveChangesAsync();

        var result = await _context.FindAsync<FeedbackDbModel>(feedback.Id);

        if (result == null)
        {
            throw new NotFoundException();
        }

        return result.ToDto();
    }

    /// <summary>
    /// Delete one Feedback
    /// </summary>
    public async Task DeleteFeedback(FeedbackWhereUniqueInput uniqueId)
    {
        var feedback = await _context.Feedbacks.FindAsync(uniqueId.Id);
        if (feedback == null)
        {
            throw new NotFoundException();
        }

        _context.Feedbacks.Remove(feedback);
        await _context.SaveChangesAsync();
    }

    /// <summary>
    /// Find many Feedbacks
    /// </summary>
    public async Task<List<Feedback>> Feedbacks(FeedbackFindManyArgs findManyArgs)
    {
        var feedbacks = await _context
            .Feedbacks.ApplyWhere(findManyArgs.Where)
            .ApplySkip(findManyArgs.Skip)
            .ApplyTake(findManyArgs.Take)
            .ApplyOrderBy(findManyArgs.SortBy)
            .ToListAsync();
        return feedbacks.ConvertAll(feedback => feedback.ToDto());
    }

    /// <summary>
    /// Meta data about Feedback records
    /// </summary>
    public async Task<MetadataDto> FeedbacksMeta(FeedbackFindManyArgs findManyArgs)
    {
        var count = await _context.Feedbacks.ApplyWhere(findManyArgs.Where).CountAsync();

        return new MetadataDto { Count = count };
    }

    /// <summary>
    /// Get one Feedback
    /// </summary>
    public async Task<Feedback> Feedback(FeedbackWhereUniqueInput uniqueId)
    {
        var feedbacks = await this.Feedbacks(
            new FeedbackFindManyArgs { Where = new FeedbackWhereInput { Id = uniqueId.Id } }
        );
        var feedback = feedbacks.FirstOrDefault();
        if (feedback == null)
        {
            throw new NotFoundException();
        }

        return feedback;
    }

    /// <summary>
    /// Update one Feedback
    /// </summary>
    public async Task UpdateFeedback(
        FeedbackWhereUniqueInput uniqueId,
        FeedbackUpdateInput updateDto
    )
    {
        var feedback = updateDto.ToModel(uniqueId);

        _context.Entry(feedback).State = EntityState.Modified;

        try
        {
            await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!_context.Feedbacks.Any(e => e.Id == feedback.Id))
            {
                throw new NotFoundException();
            }
            else
            {
                throw;
            }
        }
    }
}
