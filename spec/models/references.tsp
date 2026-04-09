namespace VidJutsu;

model Reference {
  referenceId: string;
  clientId: string;
  url: string;
  platform?: string;
  notes?: string;
  tags?: Tag[];
  metadata?: unknown;
  status: "active" | "deleted";
  createdAt: float64;
}

model ReferenceCreateRequest {
  url: string;
  platform?: string;
  notes?: string;
  tags?: Tag[];
  metadata?: unknown;
}

model ReferenceCreateResponse {
  id: string;
  status: "active";
  creditsCharged: 0;
}

model ReferenceUpdateRequest {
  url?: string;
  platform?: string;
  notes?: string;
  tags?: Tag[];
  metadata?: unknown;
}

model ReferenceUpdateResponse {
  referenceId: string;
  updated: true;
}

model ReferenceDeleteResponse {
  id: string;
  status: "deleted";
}

model ReferenceListResponse {
  data: Reference[];
}
