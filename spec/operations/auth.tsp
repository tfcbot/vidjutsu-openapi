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

// --- Free signup + balance (PR 1 of credit-billing pivot) ---

model SignupResponse {
  @doc("Fresh API key, format vj_anon_<hex>. Send as Authorization: Bearer <apiKey>.")
  apiKey: string;
  @doc("Client identifier, format mc_anon_<hex>.")
  clientId: string;
}

model LedgerEntry {
  @doc("Signed credit delta: positive for grants/topups/refunds, negative for charges.")
  delta: int32;
  reason: "grant" | "topup" | "charge" | "refund";
  @doc("Operation that produced this entry (for charge rows).")
  operationId?: string;
  @doc("Free-form admin note (for grant rows).")
  note?: string;
  @doc("Unix epoch milliseconds.")
  createdAt: int64;
}

model BalanceResponse {
  @doc("Current credit balance for the authenticated client.")
  balance: int32;
  @doc("Most recent ledger entries (newest first), up to 10.")
  ledger: LedgerEntry[];
}

@route("/v1/signup")
@tag("Credits")
interface Signup {
  @post @operationId("signup") @summary("Anonymous signup")
  @doc("Creates a new anonymous machine client and returns a fresh API key + clientId. No authentication required. Returned client starts with 0 credits and claimStatus=anonymous; credits can be granted by an admin or topped up later.")
  @useAuth(NoAuth)
  signup(): SignupResponse;
}

@route("/v1/balance")
@tag("Credits")
interface Balance {
  @get @operationId("getBalance") @summary("Get credit balance")
  @doc("Returns the authenticated client's current credit balance and the last 10 ledger entries.")
  get(): BalanceResponse;
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
  @doc("DEPRECATED (PR 2 of credit-billing pivot, 2026-05-23): subscription gating has been removed from the API. Anyone can sign up for free via POST /v1/signup and pay per call via credits — a 403 subscription_required response will no longer be returned by any endpoint. This endpoint is retained as a Stripe Checkout entry point and will be reworked in PR 3 to mint credit packs instead of subscriptions. Do not build new integrations against the existing subscription semantics.")
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
