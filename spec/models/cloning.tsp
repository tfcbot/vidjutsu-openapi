using Http;

namespace VidJutsu;

enum MediaJobStatus {
  queued,
  running,
  waitingProvider: "waiting_provider",
  retrying,
  rejected,
  completed,
  failed,
  cancelled,
}

enum MediaJobOperation {
  addVideo,
  generateClips,
  addCaptions,
  addBroll,
  schedulePost,
}

model MediaJobError {
  code: string;
  message: string;
  retryable: boolean;
}

model MediaJob {
  jobId: string;
  parentJobId?: string;
  operation: MediaJobOperation;
  status: MediaJobStatus;
  outputs?: JobOutputResource[];
  error?: MediaJobError;
  createdAt: int64;
  completedAt?: int64;
}

union CloneVideoModel {
  seedance: "seedance",
  kling: "kling",
}

enum CloneCheckVerdict {
  strong,
  possible,
  weak,
}

model CloneCheckRequest {
  @doc("Public HTTPS URL of the source video to evaluate. http:// URLs are rejected.")
  @format("uri")
  videoUrl: string;

  @doc("Optional freeform context about the intended clone (product, character, constraints) to sharpen the analysis.")
  context?: string;
}

model CloneCheckResponse {
  @doc("Overall cloneability verdict: \"strong\" clones reliably, \"possible\" may need retries or manual QA, \"weak\" is unlikely to clone well.")
  verdict: CloneCheckVerdict;

  @doc("Cloneability score from 0 (unusable) to 100 (ideal source).")
  @minValue(0)
  @maxValue(100)
  score: int32;

  @doc("Concrete observations from the video that support the verdict.")
  evidence: string[];

  @doc("Provider model id that produced the analysis.")
  `model`: string;
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

model CloneStartingImageRequest {
  @doc("Public HTTPS URL of the character identity image. http:// URLs are rejected.")
  @format("uri")
  characterImageUrl: string;

  @doc("Instructions for composing the starting frame (pose, framing, scene).")
  @minLength(1)
  prompt: string;

  @doc("Optional public HTTPS URL of the source video whose opening frame should ground the composition.")
  @format("uri")
  sourceVideoUrl?: string;
}

model CloneVideoRequest {
  @doc("Public HTTPS URL of the starting frame that carries the target identity. http:// URLs are rejected.")
  @format("uri")
  startingImageUrl: string;

  @doc("Public HTTPS URL of the source video whose motion is cloned. http:// URLs are rejected.")
  @format("uri")
  sourceVideoUrl: string;

  @doc("Generation model. Defaults to \"seedance\" (9:16 at 480p, video-edit); \"kling\" uses Kling motion control and keeps the original sound.")
  `model`?: CloneVideoModel = CloneVideoModel.seedance;

  @doc("Optional override for the default identity-swap prompt (seedance only).")
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
