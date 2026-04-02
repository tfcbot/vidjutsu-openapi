using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/analytics")
@tag("Analytics")
interface Analytics {
  @get @operationId("getAnalytics") @summary("Get account analytics")
  get(@query accountId: string): AccountAnalytics;

  @route("/refresh")
  @post @operationId("refreshAnalytics") @summary("Refresh analytics")
  refresh(@body body: { accountId: string }): AnalyticsRefreshResponse;

  @route("/videos")
  @get @operationId("getVideoStats") @summary("Get video stats")
  videos(@query accountId: string): VideoStatsResponse;
}
