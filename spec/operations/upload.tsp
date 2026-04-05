using Http;
using OpenAPI;

namespace VidJutsu;

model UploadResponse {
  id: string;
  assetId: string;
  url: string;
  clientId: string;
}

model UploadUrlRequest {
  sourceUrl: string;
  contentType?: string;
}

@route("/v1/upload")
@tag("Upload")
interface Upload {
  @post @operationId("uploadFile") @summary("Upload file")
  upload(@header contentType: string, @body body: bytes): {
    @statusCode _: 201;
    @body body: UploadResponse;
  };
}

@route("/v1/upload/url")
@tag("Upload")
interface UploadUrl {
  @post @operationId("uploadFromUrl") @summary("Upload from URL")
  uploadFromUrl(@body body: UploadUrlRequest): {
    @statusCode _: 201;
    @body body: UploadResponse;
  };
}
