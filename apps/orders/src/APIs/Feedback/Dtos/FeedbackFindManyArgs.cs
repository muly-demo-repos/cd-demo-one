using Microsoft.AspNetCore.Mvc;
using Orders.APIs.Common;
using Orders.Infrastructure.Models;

namespace Orders.APIs.Dtos;

[BindProperties(SupportsGet = true)]
public class FeedbackFindManyArgs : FindManyInput<Feedback, FeedbackWhereInput> { }
