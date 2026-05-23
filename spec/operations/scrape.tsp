using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/scrape")
@tag("Scrape")
interface Scrape {
  @doc("Ads for a company in the Google Ad Transparency Library. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/ads/google") @operationId("scrapeGoogleAds") @summary("Scrape Google Ad Transparency")
  scrapeGoogleAds(@body body: ScrapeGoogleAdsRequest): ScrapeResponse;

  @doc("Active LinkedIn ads matching keyword. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/ads/linkedin") @operationId("scrapeLinkedInAds") @summary("Scrape LinkedIn Ad Library")
  scrapeLinkedInAds(@body body: ScrapeLinkedInAdsRequest): ScrapeResponse;

  @doc("Active Meta ads matching keyword. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/ads/meta") @operationId("scrapeMetaAds") @summary("Scrape Meta (Facebook) Ad Library")
  scrapeMetaAds(@body body: ScrapeMetaAdsRequest): ScrapeResponse;

  @doc("Active Reddit ads matching keyword. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/ads/reddit") @operationId("scrapeRedditAds") @summary("Scrape Reddit Ad Library")
  scrapeRedditAds(@body body: ScrapeRedditAdsRequest): ScrapeResponse;

  @doc("Single Instagram post or reel + media URLs. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/instagram/post") @operationId("scrapeInstagramPost") @summary("Scrape Instagram post or reel")
  scrapeInstagramPost(@body body: ScrapeInstagramPostRequest): ScrapeResponse;

  @doc("Comments on an Instagram post or reel. 1 op.")
  @post @route("/instagram/post/comments") @operationId("scrapeInstagramPostComments") @summary("Scrape Instagram post comments")
  scrapeInstagramPostComments(@body body: ScrapeInstagramPostCommentsRequest): ScrapeResponse;

  @doc("Public Instagram profile + recent reels. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/instagram/profile") @operationId("scrapeInstagramProfile") @summary("Scrape Instagram profile")
  scrapeInstagramProfile(@body body: ScrapeInstagramProfileRequest): ScrapeResponse;

  @doc("Paginated posts for an Instagram profile. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/instagram/user/posts") @operationId("scrapeInstagramUserPosts") @summary("Scrape Instagram user posts")
  scrapeInstagramUserPosts(@body body: ScrapeInstagramUserPostsRequest): ScrapeResponse;

  @doc("Paginated reels for an Instagram profile. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/instagram/user/reels") @operationId("scrapeInstagramUserReels") @summary("Scrape Instagram user reels")
  scrapeInstagramUserReels(@body body: ScrapeInstagramUserReelsRequest): ScrapeResponse;

  @doc("Fetch public TikTok profile data via Scrape Creators. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/tiktok/profile") @operationId("scrapeTikTokProfile") @summary("Scrape TikTok profile")
  scrapeTikTokProfile(@body body: ScrapeTikTokProfileRequest): ScrapeResponse;

  @doc("Paginated videos for a TikTok profile. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/tiktok/profile/videos") @operationId("scrapeTikTokProfileVideos") @summary("Scrape TikTok profile videos")
  scrapeTikTokProfileVideos(@body body: ScrapeTikTokProfileVideosRequest): ScrapeResponse;

  @doc("Search TikTok users by keyword. 1 op.")
  @post @route("/tiktok/search/users") @operationId("scrapeTikTokSearchUsers") @summary("Scrape TikTok user search")
  scrapeTikTokSearchUsers(@body body: ScrapeTikTokSearchUsersRequest): ScrapeResponse;

  @doc("Trending feed by region. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/tiktok/trending") @operationId("scrapeTikTokTrending") @summary("Scrape TikTok trending feed")
  scrapeTikTokTrending(@body body: ScrapeTikTokTrendingRequest): ScrapeResponse;

  @doc("Single TikTok video metadata + media URLs. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/tiktok/video") @operationId("scrapeTikTokVideo") @summary("Scrape TikTok video")
  scrapeTikTokVideo(@body body: ScrapeTikTokVideoRequest): ScrapeResponse;

  @doc("Comments on a TikTok video. 1 op.")
  @post @route("/tiktok/video/comments") @operationId("scrapeTikTokVideoComments") @summary("Scrape TikTok video comments")
  scrapeTikTokVideoComments(@body body: ScrapeTikTokVideoCommentsRequest): ScrapeResponse;

  @doc("Spoken transcript for a TikTok video. 1 op.")
  @post @route("/tiktok/video/transcript") @operationId("scrapeTikTokVideoTranscript") @summary("Scrape TikTok video transcript")
  scrapeTikTokVideoTranscript(@body body: ScrapeTikTokVideoTranscriptRequest): ScrapeResponse;

  @doc("Public X/Twitter profile + stats. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/twitter/profile") @operationId("scrapeTwitterProfile") @summary("Scrape X profile")
  scrapeTwitterProfile(@body body: ScrapeTwitterProfileRequest): ScrapeResponse;

  @doc("Single tweet + media. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/twitter/tweet") @operationId("scrapeTwitterTweet") @summary("Scrape X tweet")
  scrapeTwitterTweet(@body body: ScrapeTwitterTweetRequest): ScrapeResponse;

  @doc("Transcript of the video in a tweet (when present). 1 op.")
  @post @route("/twitter/tweet/transcript") @operationId("scrapeTwitterTweetTranscript") @summary("Scrape X tweet video transcript")
  scrapeTwitterTweetTranscript(@body body: ScrapeTwitterTweetTranscriptRequest): ScrapeResponse;

  @doc("Recent tweets for a handle. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/twitter/user-tweets") @operationId("scrapeTwitterUserTweets") @summary("Scrape X user tweets")
  scrapeTwitterUserTweets(@body body: ScrapeTwitterUserTweetsRequest): ScrapeResponse;

  @doc("YouTube channel info + stats. Provide handle or channel_id. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/youtube/channel") @operationId("scrapeYouTubeChannel") @summary("Scrape YouTube channel")
  scrapeYouTubeChannel(@body body: ScrapeYouTubeChannelRequest): ScrapeResponse;

  @doc("Paginated videos for a channel. Provide handle or channel_id. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/youtube/channel-videos") @operationId("scrapeYouTubeChannelVideos") @summary("Scrape YouTube channel videos")
  scrapeYouTubeChannelVideos(@body body: ScrapeYouTubeChannelVideosRequest): ScrapeResponse;

  @doc("Single YouTube video info, including transcript. 1 op + 1 op per staged media file when download_media is true.")
  @post @route("/youtube/video") @operationId("scrapeYouTubeVideo") @summary("Scrape YouTube video")
  scrapeYouTubeVideo(@body body: ScrapeYouTubeVideoRequest): ScrapeResponse;

  @doc("Comments on a YouTube video. 1 op.")
  @post @route("/youtube/video/comments") @operationId("scrapeYouTubeVideoComments") @summary("Scrape YouTube video comments")
  scrapeYouTubeVideoComments(@body body: ScrapeYouTubeVideoCommentsRequest): ScrapeResponse;

}
