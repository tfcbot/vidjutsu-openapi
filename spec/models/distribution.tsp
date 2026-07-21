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
  schedulePost,
}

enum VideoStatus {
  processing,
  ready,
  failed,
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

model JobOutputResource {
  kind: "video" | "post" | "image" | "character" | "clone_check";
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

model DistributionJobAcceptedResponse {
  @statusCode _: 202;
  @body body: DistributionJob;
}

model VideoResponse {
  data: Video;
}
