using Http;
using OpenAPI;

namespace VidJutsu;

model BreakdownRequest {
  mediaUrl: string;
  mediaType: "video" | "image";
  prompt?: string;
}

model BreakdownCreateResponse {
  id: string;
  status: "pending";
}

model BreakdownGetResponse {
  id: string;
  status: string;
  result?: unknown;
}

@route("/v1/breakdown")
@tag("Breakdown")
interface Breakdown {
  @post @operationId("createBreakdown") @summary("Create media breakdown")
  create(@body body: BreakdownRequest): BreakdownCreateResponse;

  @get @operationId("getBreakdown") @summary("Get breakdown result")
  get(@query id: string): BreakdownGetResponse;
}
