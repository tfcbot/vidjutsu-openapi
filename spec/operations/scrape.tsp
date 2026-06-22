using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/scrape")
@tag("Scrape")
interface Scrape {
  @doc("Ads for a company in the Google Ad Transparency Library. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/ads/google") @operationId("scrapeGoogleAds") @summary("Scrape Google Ad Transparency")
  scrapeGoogleAds(@body body: ScrapeGoogleAdsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Active LinkedIn ads matching keyword. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/ads/linkedin") @operationId("scrapeLinkedInAds") @summary("Scrape LinkedIn Ad Library")
  scrapeLinkedInAds(@body body: ScrapeLinkedInAdsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Active Meta ads matching keyword. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/ads/meta") @operationId("scrapeMetaAds") @summary("Scrape Meta (Facebook) Ad Library")
  scrapeMetaAds(@body body: ScrapeMetaAdsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Active Reddit ads matching keyword. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/ads/reddit") @operationId("scrapeRedditAds") @summary("Scrape Reddit Ad Library")
  scrapeRedditAds(@body body: ScrapeRedditAdsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Single Instagram post or reel + media URLs. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/instagram/post") @operationId("scrapeInstagramPost") @summary("Scrape Instagram post or reel")
  scrapeInstagramPost(@body body: ScrapeInstagramPostRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Comments on an Instagram post or reel. 1 op.")
  @post @route("/instagram/post/comments") @operationId("scrapeInstagramPostComments") @summary("Scrape Instagram post comments")
  scrapeInstagramPostComments(@body body: ScrapeInstagramPostCommentsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Public Instagram profile + recent reels. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/instagram/profile") @operationId("scrapeInstagramProfile") @summary("Scrape Instagram profile")
  scrapeInstagramProfile(@body body: ScrapeInstagramProfileRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Paginated posts for an Instagram profile. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/instagram/user/posts") @operationId("scrapeInstagramUserPosts") @summary("Scrape Instagram user posts")
  scrapeInstagramUserPosts(@body body: ScrapeInstagramUserPostsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Paginated reels for an Instagram profile. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/instagram/user/reels") @operationId("scrapeInstagramUserReels") @summary("Scrape Instagram user reels")
  scrapeInstagramUserReels(@body body: ScrapeInstagramUserReelsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Fetch public TikTok profile data via Scrape Creators. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/tiktok/profile") @operationId("scrapeTikTokProfile") @summary("Scrape TikTok profile")
  scrapeTikTokProfile(@body body: ScrapeTikTokProfileRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Paginated videos for a TikTok profile. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/tiktok/profile/videos") @operationId("scrapeTikTokProfileVideos") @summary("Scrape TikTok profile videos")
  scrapeTikTokProfileVideos(@body body: ScrapeTikTokProfileVideosRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Search TikTok users by keyword. 1 op.")
  @post @route("/tiktok/search/users") @operationId("scrapeTikTokSearchUsers") @summary("Scrape TikTok user search")
  scrapeTikTokSearchUsers(@body body: ScrapeTikTokSearchUsersRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Trending feed by region. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/tiktok/trending") @operationId("scrapeTikTokTrending") @summary("Scrape TikTok trending feed")
  scrapeTikTokTrending(@body body: ScrapeTikTokTrendingRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Single TikTok video metadata + media URLs. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/tiktok/video") @operationId("scrapeTikTokVideo") @summary("Scrape TikTok video")
  scrapeTikTokVideo(@body body: ScrapeTikTokVideoRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Comments on a TikTok video. 1 op.")
  @post @route("/tiktok/video/comments") @operationId("scrapeTikTokVideoComments") @summary("Scrape TikTok video comments")
  scrapeTikTokVideoComments(@body body: ScrapeTikTokVideoCommentsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Spoken transcript for a TikTok video. 1 op.")
  @post @route("/tiktok/video/transcript") @operationId("scrapeTikTokVideoTranscript") @summary("Scrape TikTok video transcript")
  scrapeTikTokVideoTranscript(@body body: ScrapeTikTokVideoTranscriptRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Public X/Twitter profile + stats. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/twitter/profile") @operationId("scrapeTwitterProfile") @summary("Scrape X profile")
  scrapeTwitterProfile(@body body: ScrapeTwitterProfileRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Single tweet + media. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/twitter/tweet") @operationId("scrapeTwitterTweet") @summary("Scrape X tweet")
  scrapeTwitterTweet(@body body: ScrapeTwitterTweetRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Transcript of the video in a tweet (when present). 1 op.")
  @post @route("/twitter/tweet/transcript") @operationId("scrapeTwitterTweetTranscript") @summary("Scrape X tweet video transcript")
  scrapeTwitterTweetTranscript(@body body: ScrapeTwitterTweetTranscriptRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Recent tweets for a handle. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/twitter/user-tweets") @operationId("scrapeTwitterUserTweets") @summary("Scrape X user tweets")
  scrapeTwitterUserTweets(@body body: ScrapeTwitterUserTweetsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("YouTube channel info + stats. Provide handle or channel_id. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/youtube/channel") @operationId("scrapeYouTubeChannel") @summary("Scrape YouTube channel")
  scrapeYouTubeChannel(@body body: ScrapeYouTubeChannelRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Paginated videos for a channel. Provide handle or channel_id. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/youtube/channel-videos") @operationId("scrapeYouTubeChannelVideos") @summary("Scrape YouTube channel videos")
  scrapeYouTubeChannelVideos(@body body: ScrapeYouTubeChannelVideosRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Single YouTube video info, including transcript. Counts as 1 request against the shared scrape group (500/day); staging media with download_media does not consume extra quota.")
  @post @route("/youtube/video") @operationId("scrapeYouTubeVideo") @summary("Scrape YouTube video")
  scrapeYouTubeVideo(@body body: ScrapeYouTubeVideoRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

  @doc("Comments on a YouTube video. 1 op.")
  @post @route("/youtube/video/comments") @operationId("scrapeYouTubeVideoComments") @summary("Scrape YouTube video comments")
  scrapeYouTubeVideoComments(@body body: ScrapeYouTubeVideoCommentsRequest): ScrapeResponse | SubscriptionRequiredResponse | RateLimitedResponse;

}
