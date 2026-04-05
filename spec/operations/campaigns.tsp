using Http;
using OpenAPI;

namespace VidJutsu;

// --- Campaigns ---

model CampaignEstimateRequest {
  accountId: string;
  videoCount: int32;
  durationDays?: int32;
}

model CampaignEstimateResponse {
  estimatedCredits: float64;
  breakdown: Record<unknown>;
}

model CampaignCreateRequest {
  accountId: string;
  videoCount: int32;
  durationDays?: int32;
}

model CampaignResponse {
  campaignId: string;
  status: string;
  accountId: string;
  creditsCharged?: float64;
}

model CampaignCancelRequest {
  campaignId: string;
}

model CampaignExecuteRequest {
  campaignId: string;
}

@route("/v1/campaigns")
@tag("Campaigns")
interface Campaigns {
  @get @operationId("listCampaigns") @summary("List campaigns")
  list(): CampaignResponse[];

  @post @operationId("createCampaign") @summary("Create campaign")
  create(@body body: CampaignCreateRequest): CampaignResponse;
}

@route("/v1/campaigns/estimate")
@tag("Campaigns")
interface CampaignEstimate {
  @post @operationId("estimateCampaign") @summary("Estimate campaign cost")
  estimate(@body body: CampaignEstimateRequest): CampaignEstimateResponse;
}

@route("/v1/campaigns/execute")
@tag("Campaigns")
interface CampaignExecute {
  @post @operationId("executeCampaign") @summary("Execute campaign")
  execute(@body body: CampaignExecuteRequest): CampaignResponse;
}

@route("/v1/campaigns/cancel")
@tag("Campaigns")
interface CampaignCancel {
  @post @operationId("cancelCampaign") @summary("Cancel campaign")
  cancel(@body body: CampaignCancelRequest): CampaignResponse;
}
