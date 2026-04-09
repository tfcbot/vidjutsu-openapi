using Http;
using OpenAPI;

namespace VidJutsu;

model ExtractFrame {
  index: int32;
  url: string;
}

model ExtractAudio {
  url: string;
  duration: float64;
}

model ExtractMetadata {
  width: int32;
  height: int32;
  fps: float64;
  duration: float64;
}

model ExtractRequest {
  @doc("URL of the video to extract from")
  mediaUrl: string;

  @doc("Frame indices to extract. Use [0, 75, 150] for specific frames, 'auto' for 3 evenly spaced, or 'last' for the final frame")
  frames?: unknown;

  @doc("Extract audio track as WAV")
  audio?: boolean;

  @doc("Return video metadata (width, height, fps, duration). Defaults to true")
  metadata?: boolean;
}

model ExtractResponse {
  frames?: ExtractFrame[];
  audio?: ExtractAudio;
  metadata?: ExtractMetadata;
}

@route("/v1/extract")
@tag("Extract")
interface Extract {
  @post @operationId("extractMedia") @summary("Extract from media")
  @doc("Pull frames, audio, and metadata from a video via server-side ffmpeg. 5 credits.")
  extract(@body body: ExtractRequest): ExtractResponse;
}
