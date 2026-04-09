namespace VidJutsu;

enum PostStatus {
  draft,
  active,
  deleted,
}

model Post {
  postId: string;
  clientId: string;
  accountId?: string;
  videoId?: string;
  mediaUrl?: string;
  caption?: string;
  brief?: unknown;
  status: PostStatus;
  tags?: Tag[];
  createdAt: int64;
}

model PostCreateRequest {
  accountId?: string;
  videoId?: string;
  mediaUrl?: string;
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
  mediaUrl?: string;
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
  status: "deleted";
}

model PostListResponse {
  data: Post[];
}
