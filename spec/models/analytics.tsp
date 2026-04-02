namespace VidJutsu;

model AccountAnalytics {
  accountId: string;
  platform: "instagram";
  followers: int32;
  following: int32;
  posts: int32;
  engagement_rate: float32;
  avg_likes: int32;
  avg_comments: int32;
}

model VideoStat {
  id: string;
  views: int32;
  likes: int32;
  comments: int32;
  shares: int32;
}

model VideoStatsResponse {
  accountId: string;
  videos: VideoStat[];
}

model AnalyticsRefreshResponse {
  refreshed: boolean;
}
