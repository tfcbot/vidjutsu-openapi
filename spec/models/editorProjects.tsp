namespace VidJutsu;

enum EditorProjectStatus {
  draft,
  active,
  archived,
}

model EditorProject {
  projectId: string;
  clientId: string;
  name: string;

  /**
   * The serializable timeline document (Twick ProjectJSON: tracks, assets,
   * metadata, version). Stored opaquely; the editor owns its shape.
   */
  project?: Record<unknown>;

  tags?: Tag[];
  metadata?: Record<unknown>;
  status: EditorProjectStatus;
  createdAt: int64;
  updatedAt: int64;
}

model EditorProjectCreateRequest {
  name: string;
  project?: Record<unknown>;
  tags?: Tag[];
  metadata?: Record<unknown>;
}

model EditorProjectCreateResponse {
  id: string;
  status: "draft";
}

model EditorProjectUpdateRequest {
  name?: string;
  status?: EditorProjectStatus;
  project?: Record<unknown>;
  tags?: Tag[];
  metadata?: Record<unknown>;
}

model EditorProjectUpdateResponse {
  projectId: string;
  updated: true;
}

model EditorProjectDeleteResponse {
  id: string;
  status: "archived";
}

model EditorProjectListResponse {
  data: EditorProject[];
}
