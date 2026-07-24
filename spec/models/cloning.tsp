using Http;

namespace VidJutsu;

union CloneVideoModel {
  kling: "kling",
}

enum CloneCheckVerdict {
  strong,
  possible,
  weak,
}

model CloneCheckRequest {
  @doc("Public HTTPS URL of a directly fetchable MP4. Social post and webpage URLs must be staged first.")
  @format("uri")
  videoUrl: string;
}

model CloneCheckResponse {
  @doc("Overall cloneability verdict: \"strong\" clones reliably, \"possible\" may need retries or manual QA, \"weak\" is unlikely to clone well.")
  verdict: CloneCheckVerdict;

  @doc("Server-calculated cloneability score from 0 (unusable) to 100 (ideal source), derived from a fixed rubric.")
  @minValue(0)
  @maxValue(100)
  score: int32;

  @doc("Concrete observations from the video that support the verdict.")
  evidence: string[];

  @doc("Provider model id that produced the structured observations used by the server rubric.")
  `model`: string;
}

@doc("The URL is invalid or points to a TikTok/Instagram post page that must be staged first.")
model CloneCheckBadRequestResponse {
  @statusCode _: 400;
  @body body: ApiError;
}

@doc("The fetched media exceeds the 50 MB clone-check limit.")
model CloneCheckTooLargeResponse {
  @statusCode _: 413;
  @body body: ApiError;
}

@doc("The URL did not resolve to an MP4 container.")
model CloneCheckUnsupportedMediaResponse {
  @statusCode _: 415;
  @body body: ApiError;
}

@doc("The MP4 exceeds the 15-second clone-source limit.")
model CloneCheckUnprocessableResponse {
  @statusCode _: 422;
  @body body: ApiError;
}

model CreateCharacterRequest {
  @doc("Text description of the character to generate.")
  @minLength(1)
  prompt: string;

  @doc("Optional public HTTPS URL of a reference image to guide identity. http:// URLs are rejected.")
  @format("uri")
  referenceImageUrl?: string;
}

model GeneratedImageResponse {
  @doc("HTTPS CDN URL of the generated image.")
  @format("uri")
  imageUrl: string;

  @doc("Provider model id that produced the image.")
  `model`: string;
}

model CreateCharacterResponse {
  @doc("Persisted character id (char_...). Reuse it later via cloneStartingImage's characterId or GET /v1/characters/{id}.")
  id: string;

  @doc("HTTPS CDN URL of the generated character image.")
  @format("uri")
  imageUrl: string;

  @doc("Provider model id that produced the image.")
  `model`: string;
}

model Character {
  @doc("Persisted character id (char_...).")
  id: string;

  @doc("HTTPS CDN URL of the character image.")
  @format("uri")
  imageUrl: string;

  @doc("Provider model id that produced the image.")
  `model`: string;

  @doc("Creation timestamp, epoch milliseconds.")
  createdAt: int64;
}

model ListCharactersResponse {
  @doc("Characters owned by the caller, most recent first.")
  characters: Character[];
}

model CloneStartingImageRequest {
  @doc("Public HTTPS URL of the source video's extracted first-frame image. This image supplies the pose, framing, lighting, background, and composition to preserve. http:// URLs are rejected.")
  @format("uri")
  firstFrame: string;

  @doc("Id of a previously created character (from createCharacter or GET /v1/characters) whose stored image supplies the replacement identity.")
  characterId: string;

  @doc("Instructions for composing the starting frame (pose, framing, scene).")
  @minLength(1)
  prompt: string;

}

model CloneVideoRequest {
  @doc("Public HTTPS URL of the starting frame that carries the target identity. http:// URLs are rejected.")
  @format("uri")
  startingImageUrl: string;

  @doc("Public HTTPS URL of the source video whose motion is cloned. http:// URLs are rejected.")
  @format("uri")
  sourceVideoUrl: string;

  @doc("Generation model. Only \"kling\" is supported: Kling 3.0 Motion Control puppets the character image with the source video's motion and keeps the original sound.")
  `model`?: CloneVideoModel = CloneVideoModel.kling;

  @doc("Optional override for the default motion-control prompt.")
  prompt?: string;
}

model CloneVideoAccepted {
  @doc("Clone task id. Poll GET /v1/clones/video/{id} with it.")
  id: string;

  @doc("Always \"processing\" on acceptance.")
  status: "processing";
}

model CloneVideoAcceptedResponse {
  @statusCode _: 202;
  @body body: CloneVideoAccepted;
}

enum CloneVideoStatus {
  processing,
  completed,
  failed,
}

model CloneVideoStatusResponse {
  @doc("Clone task id.")
  id: string;

  @doc("Current task status.")
  status: CloneVideoStatus;

  @doc("HTTPS URL of the finished clone. Present only when status is \"completed\".")
  @format("uri")
  videoUrl?: string;

  @doc("Failure explanation. Present only when status is \"failed\".")
  error?: string;
}
