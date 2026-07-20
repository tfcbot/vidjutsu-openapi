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

@route("/v1/clips/generate")
@tag("Clips")
interface ClipGeneration {
  @post @operationId("generateClips") @summary("Generate a bounded batch of 9:16 clips from a video source or video ID")
  @doc("One semantic job may resolve the source, transcribe it, find moments, and reframe clips. Returns a durable job; provider and model choices remain internal.")
  generate(
    @header("Idempotency-Key") idempotencyKey?: string,
    @body body: GenerateClipsRequest,
  ): DistributionJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/clips/captions")
@tag("Clips")
interface ClipCaptions {
  @post @operationId("addClipCaptions") @summary("Create a captioned clip artifact")
  @doc("Creates a new immutable clip whose parent is the input clip.")
  add(
    @header("Idempotency-Key") idempotencyKey?: string,
    @body body: AddCaptionsRequest,
  ): DistributionJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/clips/broll")
@tag("Clips")
interface ClipBroll {
  @post @operationId("addClipBroll") @summary("Create a B-roll-treated clip artifact")
  @doc("Creates a new immutable clip whose parent is the input clip. Assets, edit planning, and render providers remain internal.")
  add(
    @header("Idempotency-Key") idempotencyKey?: string,
    @body body: AddBrollRequest,
  ): DistributionJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/distribution/jobs")
@tag("Jobs")
interface DistributionJobs {
  @get @operationId("getDistributionJob") @summary("Inspect a distribution job")
  get(@query id: string): DistributionJob | SubscriptionRequiredResponse;
}

@route("/v1/distribution/clips")
@tag("Clips")
interface DistributionClips {
  @get @operationId("listOrGetDistributionClips") @summary("List generated clips or get one by ID")
  list(@query id?: string, @query videoId?: string): ClipResponse | ClipListResponse | SubscriptionRequiredResponse;
}
