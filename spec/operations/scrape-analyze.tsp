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

model AnalysisKeyframe {
  timestamp: float64;
  type: string;
  description: string;
  visual?: string;
  audio?: string;
  text?: string;
}

model AnalysisResult {
  summary: string;
  hook: string;
  durationSeconds: float64;
  keyframes: AnalysisKeyframe[];
  tags: string[];
  whyItPerformed: string[];
  attributesToCopy: string[];
  hooksToTest: string[];
}

model AnalysisStatusResponse {
  id: string;
  status: "pending" | "analyzing" | "embedding" | "completed" | "failed";
  videoUrl: string;
  sourceType: "direct" | "social";
  createdAt: float64;
  completedAt?: float64;
  result?: AnalysisResult;
  errorMessage?: string;
}

@route("/v1/analyze")
@tag("Analyze")
interface Analyze {
  @post @operationId("analyzeMedia") @summary("Analyze media")
  analyze(@body body: AnalyzeRequest): AnalyzeResponse;

  @get @operationId("getAnalysisStatus") @summary("Poll breakdown analysis status")
  getStatus(@query id: string): AnalysisStatusResponse;
}

// --- Scrape ---

model ScrapeRequest {
  platform: "instagram";
  action: string;
  params?: Record<unknown>;
}

@route("/v1/scrape")
@tag("Scrape")
interface Scrape {
  @post @operationId("scrapeContent") @summary("Scrape creator data")
  scrape(@body body: ScrapeRequest): unknown;
}
