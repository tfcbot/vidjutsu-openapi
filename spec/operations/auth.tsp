using Http;
using OpenAPI;

namespace VidJutsu;

// --- API Keys ---

model ApiKeyCreateRequest {
  credits?: int32;
  email?: string;
  successUrl?: string;
}

model ApiKeyCreateResponse {
  url: string;
  sessionId: string;
  credits: int32;
  amount: int32;
}

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

@route("/v1/api_keys")
@tag("API Keys")
interface ApiKeys {
  @post @operationId("createApiKey") @summary("Create API key")
  create(@body body: ApiKeyCreateRequest): ApiKeyCreateResponse;

  @route("/status")
  @get @operationId("getApiKeyStatus") @summary("Check API key status")
  status(@query session: string): ApiKeyStatusResponse;

  @route("/rotate")
  @post @operationId("rotateApiKey") @summary("Rotate API key")
  rotate(): ApiKeyRotateResponse;

  @route("/recover")
  @post @operationId("recoverApiKey") @summary("Recover API key")
  recover(@body body: ApiKeyRecoverRequest): ApiKeyRecoverResponse;
}

// --- Balance ---

model BalanceResponse {
  credits: int32;
  clientId: string;
}

@route("/v1/balance")
@tag("Balance")
interface Balance {
  @get @operationId("getBalance") @summary("Get credit balance")
  get(): BalanceResponse;
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
  email?: string;
  successUrl?: string;
}

@route("/v1/subscriptions")
@tag("Subscriptions")
interface Subscriptions {
  @post @operationId("createSubscription") @summary("Create subscription")
  create(@body body: SubscriptionCreateRequest): unknown;
}
