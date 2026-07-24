using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/videos/download")
@tag("Videos")
interface SocialVideoDownloads {
  @post @route("/tiktok") @operationId("downloadTikTokVideo") @summary("Import a TikTok video into VidJutsu")
  @doc("Accepts a TikTok post URL, extracts the primary MP4 and normalized metadata from one provider response, and stores the MP4 in tenant-owned VidJutsu storage. The tenant cache is checked first; repeated imports return the stored CDN URL and metadata without provider or media fetches. Older cached assets return metadata: {} and are not backfilled.")
  downloadTikTok(
    @body body: SocialVideoDownloadRequest,
  ): SocialVideoDownloadResult | SubscriptionRequiredResponse | RateLimitedResponse;

  @post @route("/instagram") @operationId("downloadInstagramVideo") @summary("Import an Instagram video into VidJutsu")
  @doc("Accepts an Instagram post or reel URL, extracts the primary MP4 and normalized metadata from one provider response, and stores the MP4 in tenant-owned VidJutsu storage. The tenant cache is checked first; repeated imports return the stored CDN URL and metadata without provider or media fetches. Older cached assets return metadata: {} and are not backfilled.")
  downloadInstagram(
    @body body: SocialVideoDownloadRequest,
  ): SocialVideoDownloadResult | SubscriptionRequiredResponse | RateLimitedResponse;
}
