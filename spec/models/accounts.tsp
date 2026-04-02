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
  campaignId?: string;
  platform: "instagram";
  name: string;
  username?: string;
  bio?: string;
  profilePictureUrl?: string;
  linkInBio?: string;
  tokportalId?: string;
  status: AccountStatus;
  tags?: Tag[];
  createdAt: int64;
}

model AccountCreateRequest {
  platform: "instagram";
  name: string;
  username?: string;
  bio?: string;
  profilePictureUrl?: string;
  linkInBio?: string;
  tags?: Tag[];
}

model AccountCreateResponse {
  id: string;
  status: "draft";
  creditsCharged: 0;
}

model AccountUpdateRequest {
  username?: string;
  name?: string;
  bio?: string;
  profilePictureUrl?: string;
  linkInBio?: string;
  tags?: Tag[];
}

model AccountUpdateResponse {
  accountId: string;
  updated: true;
}

model AccountProvisionRequest {
  accountId: string;
  country?: string;
  niche?: string;
}

model AccountProvisionResponse {
  id: string;
  status: "creating";
  creditsCharged: 990;
}

model AccountDeleteResponse {
  id: string;
  status: "deleted";
}

model AccountListResponse {
  data: Account[];
}
