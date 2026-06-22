using Http;
using OpenAPI;

namespace VidJutsu;

// --- API Keys ---

model ApiKeyStatusResponse {
  status: "pending" | "completed";
  apiKey?: string;
  clientId?: string;
  isNew?: boolean;
}

model ApiKeyRotateResponse {
  apiKey: string;
  clientId: string;
  message: string;
}

model ApiKeyRecoverRequest {
  email: string;
}

model ApiKeyRecoverResponse {
  message: string;
}

@route("/v1/credits")
@tag("Billing")
interface Credits {
  @route("/status")
  @get @operationId("getCheckoutStatus") @summary("Check checkout status")
  @doc("Poll after starting a /v1/subscribe checkout. Once payment completes, returns the minted API key and clientId. (The /v1/credits route prefix is historical; this endpoint retrieves the subscription key, not a credit balance.)")
  status(@query session: string): ApiKeyStatusResponse;
}

@route("/v1/api_keys/rotate")
@tag("API Keys")
interface ApiKeyRotate {
  @post @operationId("rotateApiKey") @summary("Rotate API key")
  rotate(): ApiKeyRotateResponse;
}

@route("/v1/api_keys/recover")
@tag("API Keys")
interface ApiKeyRecover {
  @post @operationId("recoverApiKey") @summary("Recover API key")
  recover(@body body: ApiKeyRecoverRequest): ApiKeyRecoverResponse;
}

// --- Usage ---

model UsageWindow {
  limit: int32;
  remaining: int32;
}

model UsageResponse {
  clientId: string;
  usage: Record<UsageWindow>;
  resetsAt: string;
}

@route("/v1/usage")
@tag("Usage")
interface Usage {
  @get @operationId("getUsage") @summary("Get daily usage")
  @doc("Returns remaining rate-limit capacity per endpoint for the caller. Resets daily at 00:00 UTC.")
  get(): UsageResponse;
}

// --- Info ---

model InfoResponse {
  name: string;
  version: string;
  endpoints: Record<string>;
  auth: unknown;
  @doc("Per-endpoint daily request limits (fixed window, resets 00:00 UTC).")
  dailyLimits: DailyLimits;
}

@route("/v1/info")
@tag("Info")
interface Info {
  @get @operationId("getInfo") @summary("API info")
  get(): InfoResponse;
}

// --- Pricing ---

model SubscriptionInfo {
  @doc("Flat subscription price, e.g. \"$99/mo\".")
  price: string;
  @doc("Whether an active subscription is required for gated endpoints.")
  required: boolean;
}

model PricingResponse {
  subscription: SubscriptionInfo;
  @doc("Maximum managed accounts per subscription.")
  maxAccounts: int32;
  @doc("Per-endpoint daily request limits (fixed window, resets 00:00 UTC).")
  dailyLimits: DailyLimits;
}

@route("/v1/pricing")
@tag("Pricing")
interface Pricing {
  @get @operationId("getPricing") @summary("Get pricing")
  get(): PricingResponse;
}

// --- Subscriptions ---

model SubscriptionCreateRequest {
  email: string;
}

model SubscriptionCreateResponse {
  url: string;
  claimToken: string;
}

@route("/v1/subscribe")
@tag("Subscriptions")
interface Subscriptions {
  @post @operationId("createSubscription") @summary("Create subscription")
  @doc("Starts a Stripe Checkout session for the flat $99/mo subscription. Returns the hosted checkout `url` and a `claimToken`. After payment, poll GET /v1/credits/status with the session id to retrieve the minted API key. An active subscription is required for all gated intelligence endpoints; calls without one return 403 subscription_required.")
  create(@body body: SubscriptionCreateRequest): SubscriptionCreateResponse;
}

// --- Email Verification ---

model VerifyRequestBody {
  email: string;
}

model VerifyRequestResponse {
  sent: boolean;
}

model VerifyConfirmBody {
  email: string;
  code: string;
}

model VerifyConfirmResponse {
  status: "verified";
  apiKey: string;
  clientId: string;
}

@route("/v1/auth/verify")
@tag("Auth")
interface AuthVerify {
  @route("/request")
  @post @operationId("requestVerification") @summary("Request email verification code")
  @doc("Sends a 6-digit verification code to the email. Always returns sent: true to prevent email enumeration.")
  request(@body body: VerifyRequestBody): VerifyRequestResponse;

  @route("/confirm")
  @post @operationId("confirmVerification") @summary("Confirm email verification code")
  @doc("Validates the 6-digit code and returns API credentials if correct. Code expires after 5 minutes.")
  confirm(@body body: VerifyConfirmBody): VerifyConfirmResponse;
}
