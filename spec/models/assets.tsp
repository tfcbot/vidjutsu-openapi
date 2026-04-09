namespace VidJutsu;

enum AssetType {
  video,
  image,
  audio,
  other,
}

enum AssetStatus {
  active,
  deleted,
}

model Asset {
  assetId: string;
  clientId: string;
  name?: string;
  url: string;
  r2Key?: string;
  contentType: string;
  size?: int64;
  type: AssetType;
  tags?: Tag[];
  metadata?: Record<unknown>;
  status: AssetStatus;
  createdAt: int64;
}

model AssetCreateRequest {
  url: string;
  name?: string;
  contentType?: string;
  tags?: Tag[];
  metadata?: Record<unknown>;
}

model AssetCreateResponse {
  id: string;
  url: string;
  status: "active";
}

model AssetUpdateRequest {
  name?: string;
  tags?: Tag[];
  metadata?: Record<unknown>;
}

model AssetUpdateResponse {
  assetId: string;
  updated: true;
}

model AssetDeleteResponse {
  id: string;
  status: "deleted";
}

model AssetListResponse {
  data: Asset[];
}
