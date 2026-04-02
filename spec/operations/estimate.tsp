using Http;
using OpenAPI;

namespace VidJutsu;

model EstimateRequest {
  accounts: int32;
  posts: int32;
  platform: "instagram";
}

model EstimateResponse {
  credits: int32;
  breakdown: BreakdownItem[];
}

@route("/v1/estimate")
@tag("Estimate")
interface Estimate {
  @post @operationId("estimateCost") @summary("Estimate cost")
  estimate(@body body: EstimateRequest): EstimateResponse;
}
