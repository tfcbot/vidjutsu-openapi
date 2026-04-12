using Http;
using OpenAPI;

namespace VidJutsu;

model OverlayRequest {
  /** URL of the source video */
  videoUrl: string;
  /** Overlay text. Use \\n for line breaks. */
  text: string;
  /** Vertical text placement */
  position?: "top" | "center" | "bottom";
  /** Font size in pixels. Defaults to 4% of video height. */
  fontSize?: int32;
  /** Text outline thickness (0-10). Defaults to 2. */
  strokeThickness?: int32;
}

model OverlayResponse {
  /** Overlay asset ID */
  id: string;
  /** CDN URL of the overlaid video */
  resultUrl: string;
}

@route("/v1/overlay")
@tag("Overlay")
interface Overlay {
  @post @operationId("createOverlay") @summary("Burn text overlay onto video")
  @doc("Burns text overlay onto a video using FFmpeg ASS subtitles. Supports TikTok-safe zones, configurable font size, stroke thickness, and top/center/bottom positioning. Returns CDN URL of the result. 5 credits.")
  create(@body body: OverlayRequest): OverlayResponse;
}
