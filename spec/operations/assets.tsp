using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/assets")
@tag("Assets")
interface Assets {
  @post @operationId("createAsset") @summary("Create asset from existing URL")
  create(@body body: AssetCreateRequest): {
    @statusCode _: 201;
    @body body: AssetCreateResponse;
  };

  @put @operationId("updateAsset") @summary("Update asset metadata")
  update(@query id: string, @body body: AssetUpdateRequest): AssetUpdateResponse;

  @get @operationId("listOrGetAssets") @summary("List assets or get by ID")
  @doc("Returns a single asset if ?id= is provided, or a list. Filter by ?type=video or ?tag.key=value.")
  list(@query id?: string, @query type?: string): Asset | AssetListResponse;

  @delete @operationId("deleteAsset") @summary("Delete asset (soft)")
  delete(@query id: string): AssetDeleteResponse;
}
