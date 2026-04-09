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

model CreditCosts {
  @doc("Create account (free)")
  `accounts.create`: int32;

  @doc("Create post (free)")
  `posts.create`: int32;

  @doc("Watch media via Gemini")
  watch: int32;

  @doc("Extract frames/audio/metadata")
  extract: int32;

  @doc("Transcribe speech to text")
  transcribe: int32;

  @doc("Check spec against rules")
  check: int32;
}
