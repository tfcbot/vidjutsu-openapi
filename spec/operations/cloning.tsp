using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/jobs")
@tag("Jobs")
interface MediaJobs {
  @get @operationId("getJob") @summary("Inspect a durable VidJutsu media job")
  get(@query id: string): MediaJob | SubscriptionRequiredResponse;
}

@route("/v1/clones/check")
@tag("Cloning")
interface CloneChecks {
  @post @operationId("cloneCheck") @summary("Evaluate whether a source video can be cloned reliably")
  @doc("Runs a synchronous, deterministic cloneability analysis of the source video and returns a verdict, a 0-100 score, and the evidence behind them. The source URL must be public HTTPS and at most ~2 minutes long. Shares the daily clone admission limit.")
  create(@body body: CloneCheckRequest): CloneCheckResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/characters")
@tag("Characters")
interface Characters {
  @post @operationId("createCharacter") @summary("Create a reusable generated character image")
  @doc("Generates a character identity image from a text prompt, optionally guided by one HTTPS reference image. Returns a CDN-hosted image URL. Synchronous; typically completes within a minute. Shares the daily clone admission limit.")
  create(@body body: CreateCharacterRequest): GeneratedImageResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/clones/starting-image")
@tag("Cloning")
interface CloneStartingImages {
  @post @operationId("cloneStartingImage") @summary("Create a character-swapped starting frame")
  @doc("Composes a clean starting frame for a clone by applying the prompt to the character image, optionally grounded in the source video's first frame. All URLs must be public HTTPS. Synchronous; typically completes within a minute. Shares the daily clone admission limit.")
  create(@body body: CloneStartingImageRequest): GeneratedImageResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/clones/video")
@tag("Cloning")
interface CloneVideos {
  @post @operationId("cloneVideo") @summary("Clone source motion with Seedance or Kling motion control")
  @doc("Submits an asynchronous motion-clone generation. The default seedance model renders 9:16 at 480p, preserving the source's timing and framing while swapping in the starting-image identity; model=\"kling\" uses Kling motion control and keeps the original sound. All URLs must be public HTTPS. Returns 202 with a task id to poll via GET /v1/clones/video/{id}.")
  create(@body body: CloneVideoRequest): CloneVideoAcceptedResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @get @operationId("getCloneVideo") @summary("Poll a clone video task")
  @doc("Returns the current status of a clone video task owned by the caller. While status is \"processing\", poll again later; on \"completed\" the videoUrl field carries the HTTPS result URL, and on \"failed\" the error field explains why. Unknown ids and other tenants' ids return 404. Status reads are not billed.")
  get(@path id: string): CloneVideoStatusResponse | SubscriptionRequiredResponse;
}
