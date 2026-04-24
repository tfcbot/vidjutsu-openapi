using Http;
using OpenAPI;

namespace VidJutsu;

model DisclaimerRequest {
  /** URL of the source video */
  videoUrl: string;
  /** Disclaimer text. Use \\n for line breaks. Kept fine-print style at the bottom of the frame. */
  text: string;
  /** Font size in pixels. Defaults to 2.2% of video height (fine-print). */
  fontSize?: int32;
}

model DisclaimerResponse {
  /** Disclaimer asset ID */
  id: string;
  /** CDN URL of the disclaimed video */
  resultUrl: string;
}

@route("/v1/disclaimer")
@tag("Disclaimer")
interface Disclaimer {
  @post @operationId("createDisclaimer") @summary("Burn fine-print disclaimer onto video")
  @doc("Burns a fine-print disclaimer centered at the bottom of a video using FFmpeg ASS subtitles. Use for FTC-style disclosures like results-not-typical, paid-endorsement, or AI-generated labels. Returns CDN URL of the result. 5 credits.")
  create(@body body: DisclaimerRequest): DisclaimerResponse;
}
