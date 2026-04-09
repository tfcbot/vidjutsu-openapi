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
  accountId?: string;
  videoId?: string;
  videoUrl?: string;
  caption?: string;
  brief?: unknown;
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
  brief?: unknown;
  tags?: Tag[];
}

model PostUpdateResponse {
  postId: string;
  updated: true;
}

model PostDeleteResponse {
  id: string;
  status: "cancelled";
}

model PostListResponse {
  data: Post[];
}
