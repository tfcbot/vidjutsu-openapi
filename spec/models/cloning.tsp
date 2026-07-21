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
