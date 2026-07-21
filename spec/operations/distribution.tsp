using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/videos/add")
@tag("Videos")
interface VideoIngestion {
  @post @operationId("addVideo") @summary("Add a video from an uploaded asset or direct MP4 URL")
  @doc("Creates or reuses a normalized Vidjutsu video. Provider ingest, downloading, indexing, and storage are implementation details.")
  add(
    @header("Idempotency-Key") idempotencyKey?: string,
    @body body: AddVideoRequest,
  ): DistributionJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/distribution/jobs")
@tag("Jobs")
interface DistributionJobs {
  @get @operationId("getDistributionJob") @summary("Inspect a distribution job")
  get(@query id: string): DistributionJob | SubscriptionRequiredResponse;
}
