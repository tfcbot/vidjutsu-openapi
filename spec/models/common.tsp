using Http;

namespace VidJutsu;

model Tag {
  key: string;
  value: string;
}

model ApiError {
  error: string;
  message: string;
  setup?: string;
}

@doc("HTTP 403 Forbidden — a valid API key with no active subscription called a gated endpoint. Body is the standard ApiError with error=\"subscription_required\".")
model SubscriptionRequiredResponse {
  @statusCode _: 403;
  @body body: ApiError;
}

@doc("HTTP 429 Too Many Requests — a per-endpoint daily rate limit was exceeded. The limit window is fixed and resets at 00:00 UTC. Body is the standard ApiError; a Retry-After header carries the seconds until reset.")
model RateLimitedResponse {
  @statusCode _: 429;
  @header("Retry-After") retryAfter?: int32;
  @body body: ApiError;
}

@doc("Per-endpoint daily request limits, keyed by endpoint name (fixed window, resets 00:00 UTC).")
model DailyLimits is Record<int32>;
