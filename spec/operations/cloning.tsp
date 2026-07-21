using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/clones/check")
@tag("Cloning")
interface CloneChecks {
  @post @operationId("cloneCheck") @summary("Evaluate whether a source video can be cloned reliably")
  @doc("Runs a synchronous, deterministic cloneability analysis of a staged source video and returns a verdict (strong, possible, or weak), a 0-100 score, and the evidence behind them, so the agent can branch on the result, for example stopping on a weak verdict. The videoUrl must be public HTTPS and staged first: provider CDNs cannot fetch TikTok or Instagram links directly, so download the source with /v1/videos/download/tiktok or /v1/videos/download/instagram before checking it. The source video must be at most ~2 minutes long. Shares the daily clone admission limit.")
  create(@body body: CloneCheckRequest): CloneCheckResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/characters")
@tag("Characters")
interface Characters {
  @post @operationId("createCharacter") @summary("Create a reusable, persisted character image")
  @doc("Generates a photoreal character identity image from a text prompt, optionally guided by one HTTPS reference image, and persists it durably under an id. Returns the character id plus a CDN-hosted image URL; reuse the id later via cloneStartingImage's characterId or fetch it again with GET /v1/characters/{id}. Synchronous; typically completes within a minute. Shares the daily clone admission limit.")
  create(@body body: CreateCharacterRequest): CreateCharacterResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @get @operationId("listCharacters") @summary("List your persisted characters")
  @doc("Returns all characters previously created by the caller, most recent first. Status/list reads are not billed.")
  list(): ListCharactersResponse | SubscriptionRequiredResponse;

  @get @operationId("getCharacter") @summary("Fetch a persisted character by id")
  @doc("Returns a single character owned by the caller. Unknown ids and other tenants' ids return 404. Status reads are not billed.")
  get(@path id: string): Character | SubscriptionRequiredResponse;
}

@route("/v1/clones/starting-image")
@tag("Cloning")
interface CloneStartingImages {
  @post @operationId("cloneStartingImage") @summary("Create a character-swapped starting frame")
  @doc("Composes a clean starting frame for a clone by applying the prompt to the character image, optionally grounded in the source video's first frame. Supply exactly one of characterImageUrl (a public HTTPS image) or characterId (a previously created character's id, from createCharacter or GET /v1/characters) to identify the character; supplying both or neither is a validation error. The returned image is guaranteed to be a clean cinematic frame with no text overlays, captions, subtitles, watermarks, or platform UI, regardless of what is present in the source video or requested prompt. All other URLs must be public HTTPS. Synchronous; typically completes within a minute. Shares the daily clone admission limit.")
  create(@body body: CloneStartingImageRequest): GeneratedImageResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/clones/video")
@tag("Cloning")
interface CloneVideos {
  @post @operationId("cloneVideo") @summary("Clone source motion with Kling motion control or Seedance")
  @doc("Submits an asynchronous motion-clone generation. The default kling model uses Kling motion control to puppet the starting-image identity with the source video's motion, keeping the original sound; model=\"seedance\" is the alternate model, rendering 9:16 at 480p via video-edit. All URLs must be public HTTPS. Source clips are capped at 15 seconds; a longer sourceVideoUrl is rejected with a 422 and an error of \"video_too_long\". Returns 202 with a task id to poll via GET /v1/clones/video/{id}.")
  create(@body body: CloneVideoRequest): CloneVideoAcceptedResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @get @operationId("getCloneVideo") @summary("Poll a clone video task")
  @doc("Returns the current status of a clone video task owned by the caller. While status is \"processing\", poll again later; on \"completed\" the videoUrl field carries the HTTPS result URL, and on \"failed\" the error field explains why. Unknown ids and other tenants' ids return 404. Status reads are not billed.")
  get(@path id: string): CloneVideoStatusResponse | SubscriptionRequiredResponse;
}
