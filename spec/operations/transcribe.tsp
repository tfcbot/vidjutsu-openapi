using Http;
using OpenAPI;

namespace VidJutsu;

model TranscribeWord {
  word: string;
  start: float64;
  end: float64;
}

model TranscribeRequest {
  @doc("URL of the video or audio to transcribe")
  mediaUrl: string;

  @doc("Language code (e.g. 'en', 'es'). Auto-detected if omitted")
  language?: string;
}

model TranscribeResponse {
  transcript: string;
  words: TranscribeWord[];
  language: string;
  duration: float64;
}

@route("/v1/transcribe")
@tag("Transcribe")
interface Transcribe {
  @post @operationId("transcribeMedia") @summary("Transcribe media")
  @doc("Speech-to-text with word-level timing via ElevenLabs. 10 credits.")
  transcribe(@body body: TranscribeRequest): TranscribeResponse;
}
