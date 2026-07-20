using Http;

namespace VidJutsu;

enum DistributionJobStatus {
  queued,
  running,
  completed,
  failed,
  cancelled,
}

enum DistributionJobOperation {
  addVideo,
  generateClips,
  addCaptions,
  addBroll,
  schedulePost,
}

enum VideoStatus {
  processing,
  ready,
  failed,
}

enum ClipStatus {
  processing,
  ready,
  failed,
}

enum ClipTransformKind {
  generated,
  timestamps,
  captions,
  broll,
}

model AssetVideoSource {
  kind: "asset";
  assetId: string;
}

model HttpVideoSource {
  kind: "http";
  @format("uri")
  url: string;
}

@discriminator("kind")
union VideoSource {
  asset: AssetVideoSource,
  http: HttpVideoSource,
}

model Video {
  videoId: string;
  sourceKind: "asset" | "http";
  status: VideoStatus;
  title?: string;
  durationSeconds?: float64;
  fingerprint?: string;
  createdAt: int64;
}

model Clip {
  clipId: string;
  rootVideoId: string;
  parentClipId?: string;
  transformKind: ClipTransformKind;
  status: ClipStatus;
  aspectRatio: "9:16";
  durationSeconds?: float64;
  assetId?: string;
  @format("uri")
  url?: string;
  createdAt: int64;
}

model JobOutputResource {
  kind: "video" | "clip" | "post" | "image" | "character" | "clone_check";
  id: string;
}

model DistributionJobError {
  code: string;
  message: string;
  retryable: boolean;
}

model DistributionJob {
  jobId: string;
  operation: DistributionJobOperation;
  status: DistributionJobStatus;
  outputs?: JobOutputResource[];
  error?: DistributionJobError;
  createdAt: int64;
  completedAt?: int64;
}

model AddVideoRequest {
  source: VideoSource;
  dryRun?: boolean;
}

model GenerateClipsRequest {
  @doc("Provide source or videoId. Exactly one is required.")
  source?: VideoSource;
  @doc("Existing normalized Vidjutsu video. Provide this or source, not both.")
  videoId?: string;
  aspectRatio: "9:16";
  @minValue(1)
  @maxValue(20)
  count: int32;
  @minValue(5)
  minDurationSeconds?: int32;
  @maxValue(180)
  maxDurationSeconds?: int32;
  intent?: string;
  dryRun?: boolean;
}

model AddCaptionsRequest {
  clipId: string;
  preset?: string;
  language?: string;
  dryRun?: boolean;
}

enum BrollMode {
  auto,
  supplied,
  none,
}

model AddBrollRequest {
  clipId: string;
  mode: BrollMode;
  @doc("Optional approved asset IDs. Required when mode is supplied.")
  assetIds?: string[];
  intent?: string;
  dryRun?: boolean;
}

model DistributionJobAcceptedResponse {
  @statusCode _: 202;
  @body body: DistributionJob;
}

model VideoResponse {
  data: Video;
}

model ClipResponse {
  data: Clip;
}

model ClipListResponse {
  data: Clip[];
}
