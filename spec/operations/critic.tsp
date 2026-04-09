using Http;
using OpenAPI;

namespace VidJutsu;

model CriticRequest {
  mediaUrl: string;
  mediaType: "video" | "image";
  context?: string;
}

model CriticResponse {
  score: float32;
  issues: string[];
  verdict: "pass" | "fail";
}

@route("/v1/critic")
@tag("Critic")
interface Critic {
  @post @operationId("criticMedia") @summary("Critic media quality")
  critic(@body body: CriticRequest): CriticResponse;
}
