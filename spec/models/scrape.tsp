namespace VidJutsu;

model ScrapeResponse {
  @doc("Pass-through response from Scrape Creators. Shape varies per endpoint. When download_media was true, all media URLs are replaced with VidJutsu CDN URLs.")
  data: unknown;
}

model ScrapeTikTokProfileRequest {
  @doc("TikTok username (without @)")
  handle: string;
  @doc("Reduce response size by trimming large fields")
  trim?: boolean;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}

model ScrapeTikTokProfileVideosRequest {
  @doc("TikTok username")
  handle: string;
  @doc("Pagination cursor")
  cursor?: string;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}

model ScrapeTikTokVideoRequest {
  @doc("TikTok video URL")
  url: string;
  @doc("Reduce response size")
  trim?: boolean;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
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
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}

model ScrapeInstagramProfileRequest {
  @doc("Instagram username (without @)")
  handle: string;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}

model ScrapeInstagramUserPostsRequest {
  @doc("Instagram username")
  handle: string;
  @doc("Pagination cursor")
  cursor?: string;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}

model ScrapeInstagramPostRequest {
  @doc("Instagram post or reel URL")
  url: string;
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
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
  @doc("When true, media URLs in the response are staged through VidJutsu CDN and the response contains ONLY VidJutsu URLs. Defaults to false (raw source URLs returned as-is).")
  download_media?: boolean = false;
}
