namespace VidJutsu;

union SocialVideoPlatform {
  tiktok: "tiktok",
  instagram: "instagram",
}

model SocialVideoDownloadRequest {
  @format("uri")
  url: string;
}

model SocialVideoStats {
  views?: int64;
  likes?: int64;
  comments?: int64;
  shares?: int64;
}

model SocialVideoMetadata {
  @doc("Original post caption, when provided by the source.")
  caption?: string;
  @doc("Source account handle without the @ prefix.")
  authorHandle?: string;
  @doc("Source account display name.")
  authorName?: string;
  @doc("Unique hashtags parsed from the caption, without # prefixes.")
  hashtags?: string[];
  @doc("Source post timestamp in Unix epoch milliseconds.")
  postedAt?: int64;
  @doc("Source video duration in seconds.")
  durationSeconds?: float64;
  @doc("Source cover image URL.")
  @format("uri")
  coverUrl?: string;
  @doc("Available engagement counts from the source response.")
  stats?: SocialVideoStats;
}

model SocialVideoDownloadResult {
  assetId: string;
  @format("uri")
  url: string;
  platform: SocialVideoPlatform;
  externalId: string;
  @format("uri")
  sourceUrl: string;
  contentType: "video/mp4";
  size: int64;
  sha256: string;
  reused: boolean;
  @doc("Normalized source metadata. Always present; older cached assets return an empty object.")
  metadata: SocialVideoMetadata;
}
