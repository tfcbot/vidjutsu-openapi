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

@doc("RFC 7807 Problem Details body returned with HTTP 402 when the caller's credit balance is insufficient for the requested operation. Content-Type: application/problem+json.")
model PaymentRequiredProblem {
  @doc("Problem type URI.")
  type: string = "https://paymentauth.org/problems/payment-required";

  @doc("Short human-readable summary.")
  title: string = "Payment Required";

  @doc("HTTP status code (always 402 here).")
  status: int32 = 402;

  @doc("Human-readable explanation of the failure.")
  detail: string;

  @doc("Credits required to perform this call.")
  required: int32;

  @doc("Caller's current credit balance.")
  balance: int32;

  @doc("URL the caller (or a payment-capable agent) should visit to top up credits.")
  topupUrl: string;
}

@doc("HTTP 402 Payment Required — insufficient credits to perform this call. Response body follows RFC 7807 (application/problem+json) and includes the credit cost, current balance, and a top-up URL. PR 3 of the credit-billing pivot will pair this with WWW-Authenticate: Payment headers to enable agent-driven (MPP / x402) inline payment resolution.")
model PaymentRequiredResponse {
  @statusCode _: 402;
  @header contentType: "application/problem+json";
  @body body: PaymentRequiredProblem;
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
