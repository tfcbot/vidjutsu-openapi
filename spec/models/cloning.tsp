using Http;

namespace VidJutsu;

enum MediaJobStatus {
  queued,
  running,
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
  cloneCheck,
  createCharacter,
  cloneStartingImage,
  cloneVideo,
}

union VideoCloneModel {
  seedance: "seedance",
  klingMotionControl: "kling-motion-control",
}

enum CloneCheckVerdict {
  recommended,
  marginal,
  notRecommended: "not_recommended",
}

model CloneCheckEvidence {
  criterion: string;
  observation: string;
  timestamps: float64[];
}

model CloneCheckResult {
  kind: "clone_check";
  checkId: string;
  @minValue(0)
  @maxValue(100)
  successPercent: int32;
  verdict: CloneCheckVerdict;
  evidence: CloneCheckEvidence[];
  failedCriteria: string[];
  recommendedModel: VideoCloneModel;
  rubricVersion: string;
}

model CharacterResult {
  kind: "character";
  characterId: string;
  identityImageAssetId: string;
}

model StartingImageResult {
  kind: "starting_image";
  assetId: string;
  @format("uri")
  url?: string;
  characterId: string;
  sourceFingerprint: string;
}

model CloneVideoResult {
  kind: "clone_video";
  assetId: string;
  @format("uri")
  url?: string;
  `model`: VideoCloneModel;
  cloneCheckId: string;
  qaScore?: int32;
}

union MediaJobResult {
  cloneCheck: CloneCheckResult,
  character: CharacterResult,
  startingImage: StartingImageResult,
  cloneVideo: CloneVideoResult,
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
  result?: MediaJobResult;
  error?: MediaJobError;
  createdAt: int64;
  completedAt?: int64;
}

model CloneCheckRequest {
  source: VideoSource;
  rubricVersion?: string;
  dryRun?: boolean;
}

model CreateCharacterRequest {
  @minLength(1)
  prompt: string;
  referenceImageAssetIds?: string[];
  dryRun?: boolean;
}

model CloneStartingImageRequest {
  source: VideoSource;
  characterId: string;
  dryRun?: boolean;
}

model LowScoreOverride {
  allowLowScore: true;
  @minLength(1)
  reason: string;
}

model CloneVideoRequest {
  source: VideoSource;
  startingImageAssetId: string;
  `model`: VideoCloneModel;
  cloneCheckId: string;
  override?: LowScoreOverride;
  dryRun?: boolean;
}

model MediaJobAcceptedResponse {
  @statusCode _: 202;
  @body body: MediaJob;
}
