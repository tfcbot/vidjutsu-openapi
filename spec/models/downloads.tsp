namespace VidJutsu;

union SocialVideoPlatform {
  tiktok: "tiktok",
  instagram: "instagram",
}

model SocialVideoDownloadRequest {
  @format("uri")
  url: string;
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
}
