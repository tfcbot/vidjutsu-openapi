using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/clones/check")
@tag("Cloning")
interface CloneChecks {
  @post @operationId("cloneCheck") @summary("Evaluate whether a source video can be cloned reliably")
  @doc("Synchronously analyzes a directly fetchable public HTTPS MP4 and returns a verdict, score, evidence, and model. TikTok and Instagram post pages must first be staged with their video download endpoint, then the exact returned CDN URL passed as videoUrl. The source must be an MP4 no larger than 50 MB and no longer than 15 seconds. Captions and overlays that can be removed and reapplied do not independently reduce cloneability. Shares the daily clone admission limit.")
  create(@body body: CloneCheckRequest):
    | CloneCheckResponse
    | CloneCheckBadRequestResponse
    | CloneCheckTooLargeResponse
    | CloneCheckUnsupportedMediaResponse
    | CloneCheckUnprocessableResponse
    | SubscriptionRequiredResponse
    | RateLimitedResponse;
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
  @doc("Edits the supplied firstFrame image with google/gemini-3.1-flash-image through the caller's tenant-scoped Vercel AI Gateway key. The first frame supplies pose, framing, lighting, background, and composition; the required characterId supplies the replacement identity. The returned image is generated with a server-enforced instruction to remove text overlays, captions, subtitles, watermarks, and platform UI. firstFrame must be public HTTPS. Synchronous; typically completes within a minute. Shares the daily clone admission limit.")
  create(@body body: CloneStartingImageRequest): GeneratedImageResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/clones/video")
@tag("Cloning")
interface CloneVideos {
  @post @operationId("cloneVideo") @summary("Clone source motion with Kling 3.0 Motion Control")
  @doc("Submits an asynchronous Kling 3.0 Motion Control generation. The starting-image identity is puppeted with the source video's motion while keeping the original sound. All URLs must be public HTTPS. Source clips are capped at 15 seconds; a longer sourceVideoUrl is rejected with a 422 and an error of \"video_too_long\". Returns 202 with a task id to read via GET /v1/clones/video/{id}.")
  create(@body body: CloneVideoRequest): CloneVideoAcceptedResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @get @operationId("getCloneVideo") @summary("Poll a clone video task")
  @doc("Returns the current status of a clone video task owned by the caller. While status is \"processing\", poll again later; on \"completed\" the videoUrl field carries the HTTPS result URL, and on \"failed\" the error field explains why. Unknown ids and other tenants' ids return 404. Status reads are not billed.")
  get(@path id: string): CloneVideoStatusResponse | SubscriptionRequiredResponse;
}
