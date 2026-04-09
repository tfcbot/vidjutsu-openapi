using Http;
using OpenAPI;

namespace VidJutsu;

model ScoreRequest {
  mediaUrl: string;
  mediaType: string;
  content?: string;
  niches?: string[];
  type?: string;
}

model ScoreResponse {
  score: float32;
  breakdown: Record<unknown>;
  suggestions: string[];
}

@route("/v1/score")
@tag("Score")
interface Score {
  @post @operationId("scoreMedia") @summary("Score media content")
  score(@body body: ScoreRequest): ScoreResponse;
}
