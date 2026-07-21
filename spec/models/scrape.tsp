namespace VidJutsu;

model ScrapeResponse {
  @doc("Pass-through response from Scrape Creators. Shape varies per endpoint. Media URLs are the raw provider source URLs; scrape never stages media. To stage a specific video's file, call the single-video download endpoint.")
  data: unknown;
}

model ScrapeTikTokProfileRequest {
  @doc("TikTok username (without @)")
  handle: string;
  @doc("Reduce response size by trimming large fields")
  trim?: boolean;
}

model ScrapeTikTokProfileVideosRequest {
  @doc("TikTok username")
  handle: string;
  @doc("Pagination cursor")
  cursor?: string;
}

model ScrapeTikTokVideoRequest {
  @doc("TikTok video URL")
  url: string;
  @doc("Reduce response size")
  trim?: boolean;
}

model ScrapeTikTokVideoTranscriptRequest {
  @doc("TikTok video URL")
  url: string;
}

model ScrapeTikTokVideoCommentsRequest {
  @doc("TikTok video URL")
  url: string;
  @doc("Pagination cursor")
  cursor?: string;
}

model ScrapeTikTokSearchUsersRequest {
  @doc("Search query")
  query: string;
  @doc("Pagination cursor")
  cursor?: string;
}

model ScrapeTikTokTrendingRequest {
  @doc("Two-letter ISO country code (e.g. 'us')")
  country?: string;
}

model ScrapeInstagramProfileRequest {
  @doc("Instagram username (without @)")
  handle: string;
}

model ScrapeInstagramUserPostsRequest {
  @doc("Instagram username")
  handle: string;
  @doc("Pagination cursor")
  cursor?: string;
}

model ScrapeInstagramPostRequest {
  @doc("Instagram post or reel URL")
  url: string;
}

model ScrapeInstagramPostCommentsRequest {
  @doc("Instagram post URL")
  url: string;
  @doc("Pagination cursor")
  cursor?: string;
}

model ScrapeInstagramUserReelsRequest {
  @doc("Instagram username")
  handle: string;
  @doc("Pagination cursor")
  cursor?: string;
}
