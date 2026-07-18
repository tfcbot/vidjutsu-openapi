using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/clones/check")
@tag("Cloning")
interface CloneChecks {
  @post @operationId("cloneCheck") @summary("Evaluate whether a source video can be cloned reliably")
  @doc("Starts a durable EVE-backed analysis job. The result contains a deterministic cloneability score grounded in prompted VidJutsu watch evidence.")
  create(
    @header("Idempotency-Key") idempotencyKey: string,
    @body body: CloneCheckRequest,
  ): MediaJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/characters")
@tag("Characters")
interface Characters {
  @post @operationId("createCharacter") @summary("Create a reusable generated character")
  create(
    @header("Idempotency-Key") idempotencyKey: string,
    @body body: CreateCharacterRequest,
  ): MediaJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/clones/starting-image")
@tag("Cloning")
interface CloneStartingImages {
  @post @operationId("cloneStartingImage") @summary("Create a clean character-swapped starting frame")
  create(
    @header("Idempotency-Key") idempotencyKey: string,
    @body body: CloneStartingImageRequest,
  ): MediaJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/clones/video")
@tag("Cloning")
interface CloneVideos {
  @post @operationId("cloneVideo") @summary("Clone source motion with Seedance or Kling motion control")
  create(
    @header("Idempotency-Key") idempotencyKey: string,
    @body body: CloneVideoRequest,
  ): MediaJobAcceptedResponse | SubscriptionRequiredResponse;
}

@route("/v1/jobs")
@tag("Jobs")
interface MediaJobs {
  @get @operationId("getJob") @summary("Inspect a durable VidJutsu media job")
  get(@query id: string): MediaJob | SubscriptionRequiredResponse;
}
