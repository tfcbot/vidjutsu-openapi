using Http;
using OpenAPI;

namespace VidJutsu;

// --- Analyze ---

model AnalyzeRequest {
  mode: "critic" | "verify" | "breakdown";
  mediaUrl: string;
  mediaType?: string;
  context?: string;
  description?: string;
  keyframeDescriptions?: string[];
  prompt?: string;
}

model AnalyzeResponse {
  id?: string;
  status?: string;
  creditsCharged: 10;
}

@route("/v1/analyze")
@tag("Analyze")
interface Analyze {
  @post @operationId("analyzeMedia") @summary("Analyze media")
  analyze(@body body: AnalyzeRequest): AnalyzeResponse;
}
