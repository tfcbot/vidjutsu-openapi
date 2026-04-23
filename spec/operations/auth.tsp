using Http;
using OpenAPI;

namespace VidJutsu;

// --- API Keys ---

model ApiKeyStatusResponse {
  status: "pending" | "completed";
  apiKey?: string;
  clientId?: string;
  balance?: int32;
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
@tag("Credits")
interface Credits {
  @route("/status")
  @get @operationId("getCheckoutStatus") @summary("Check checkout status")
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

// --- Info ---

model InfoResponse {
  name: string;
  version: string;
  endpoints: Record<string>;
  auth: unknown;
  credits: CreditCosts;
}

@route("/v1/info")
@tag("Info")
interface Info {
  @get @operationId("getInfo") @summary("API info")
  get(): InfoResponse;
}

// --- Pricing ---

model SubscriptionInfo {
  price: string;
  includedCredits: int32;
  required: boolean;
}

model PricingResponse {
  subscription: SubscriptionInfo;
  pricePerCredit: string;
  maxAccounts: int32;
  costs: CreditCosts;
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
