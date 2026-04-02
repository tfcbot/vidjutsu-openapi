namespace VidJutsu;

enum PostStatus {
  draft,
  scheduled,
  posting,
  posted,
  failed,
  cancelled,
}

model Post {
  postId: string;
  clientId: string;
  campaignId?: string;
  accountId?: string;
  videoId?: string;
  videoUrl?: string;
  caption?: string;
  brief?: unknown;
  scheduledAt?: int64;
  status: PostStatus;
  metrics?: unknown;
  tags?: Tag[];
  createdAt: int64;
}

model PostCreateRequest {
  accountId?: string;
  videoId?: string;
  videoUrl?: string;
  caption?: string;
  brief?: unknown;
  scheduledAt?: int64;
  tags?: Tag[];
}

model PostCreateResponse {
  id: string;
  status: "draft";
  creditsCharged: 0;
}

model PostUpdateRequest {
  caption?: string;
  videoUrl?: string;
  videoId?: string;
  accountId?: string;
  scheduledAt?: int64;
  brief?: unknown;
  tags?: Tag[];
}

model PostUpdateResponse {
  postId: string;
  updated: true;
}

model PostScheduleRequest {
  postId: string;
}

model PostScheduleResponse {
  id: string;
  status: "scheduled";
  creditsCharged: 36;
}

model PostAssignRequest {
  postId: string;
  accountId: string;
}

model PostAssignResponse {
  postId: string;
  accountId: string;
  status: "assigned";
}

model PostDuplicateRequest {
  postId: string;
  accountId?: string;
}

model PostDuplicateResponse {
  id: string;
  status: "draft";
  creditsCharged: 0;
}

model PostDeleteResponse {
  id: string;
  status: "cancelled";
}

model PostListResponse {
  data: Post[];
}
