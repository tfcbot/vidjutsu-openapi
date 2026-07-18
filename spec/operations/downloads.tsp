using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/videos/download")
@tag("Videos")
interface SocialVideoDownloads {
  @post @route("/tiktok") @operationId("downloadTikTokVideo") @summary("Import a TikTok video into VidJutsu")
  @doc("Imports the primary video from a TikTok post into tenant-owned VidJutsu storage. Repeated imports reuse the same immutable asset.")
  downloadTikTok(
    @body body: SocialVideoDownloadRequest,
  ): SocialVideoDownloadResult | SubscriptionRequiredResponse | RateLimitedResponse;

  @post @route("/instagram") @operationId("downloadInstagramVideo") @summary("Import an Instagram video into VidJutsu")
  @doc("Imports the primary video from an Instagram post or reel into tenant-owned VidJutsu storage. Repeated imports reuse the same immutable asset.")
  downloadInstagram(
    @body body: SocialVideoDownloadRequest,
  ): SocialVideoDownloadResult | SubscriptionRequiredResponse | RateLimitedResponse;
}
