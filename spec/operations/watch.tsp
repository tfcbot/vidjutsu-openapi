using Http;
using OpenAPI;

namespace VidJutsu;

model WatchRequest {
  @doc("URL of the media to analyze")
  mediaUrl: string;

  @doc("Freeform prompt — tell Gemini what to look for")
  prompt: string;
}

model WatchResponse {
  @doc("Structured JSON response from Gemini based on the prompt")
  response: Record<unknown>;
}

@route("/v1/watch")
@tag("Watch")
interface Watch {
  @post @operationId("watchMedia") @summary("Watch media")
  @doc("Gemini watches a video or image and answers your freeform prompt. Returns structured JSON. 10 credits.")
  watch(@body body: WatchRequest): WatchResponse;
}
