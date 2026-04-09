namespace VidJutsu;

enum AccountStatus {
  draft,
  creating,
  active,
  suspended,
  deleted,
}

model Account {
  accountId: string;
  clientId: string;
  platform: "instagram";
  name: string;
  handle?: string;
  bio?: string;
  pfp?: string;
  niche?: string;
  linkInBio?: string;
  status: AccountStatus;
  tags?: Tag[];
  createdAt: int64;
}

model AccountCreateRequest {
  platform: "instagram";
  name: string;
  handle?: string;
  bio?: string;
  pfp?: string;
  niche?: string;
  linkInBio?: string;
  tags?: Tag[];
}

model AccountCreateResponse {
  id: string;
  status: "draft";
  creditsCharged: 0;
}

model AccountUpdateRequest {
  handle?: string;
  name?: string;
  bio?: string;
  pfp?: string;
  niche?: string;
  linkInBio?: string;
  tags?: Tag[];
}

model AccountUpdateResponse {
  accountId: string;
  updated: true;
}

model AccountDeleteResponse {
  id: string;
  status: "deleted";
}

model AccountListResponse {
  data: Account[];
}
