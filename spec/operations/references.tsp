using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/references")
@tag("References")
interface References {
  @post @operationId("createReference") @summary("Create reference")
  create(@body body: ReferenceCreateRequest): {
    @statusCode _: 201;
    @body body: ReferenceCreateResponse;
  };

  @put @operationId("updateReference") @summary("Update reference")
  update(@query id: string, @body body: ReferenceUpdateRequest): ReferenceUpdateResponse;

  @get @operationId("listOrGetReferences") @summary("List references or get by ID")
  @doc("Returns a single reference if ?id= is provided, or a list. Filter by ?platform= or ?tag.key=value.")
  list(@query id?: string, @query platform?: string): Reference | ReferenceListResponse;

  @delete @operationId("deleteReference") @summary("Delete reference")
  delete(@query id: string): ReferenceDeleteResponse;
}
