using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/jobs")
@tag("Jobs")
interface MediaJobs {
  @get @operationId("getJob") @summary("Inspect a durable VidJutsu media job")
  get(@query id: string): MediaJob | SubscriptionRequiredResponse;
}
