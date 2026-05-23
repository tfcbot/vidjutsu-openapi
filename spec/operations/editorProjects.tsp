using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/projects")
@tag("Editor Projects")
interface EditorProjects {
  @post @operationId("createEditorProject") @summary("Create editor project")
  create(@body body: EditorProjectCreateRequest): {
    @statusCode _: 201;
    @body body: EditorProjectCreateResponse;
  };

  @put @operationId("updateEditorProject") @summary("Update editor project")
  update(@query id: string, @body body: EditorProjectUpdateRequest): EditorProjectUpdateResponse;

  @get @operationId("listOrGetEditorProjects") @summary("List projects or get by ID")
  @doc("Returns a single project if ?id= is provided, or a list. Filter by ?status= or ?tag.key=value.")
  list(@query id?: string, @query status?: string): EditorProject | EditorProjectListResponse;

  @delete @operationId("deleteEditorProject") @summary("Archive editor project (soft)")
  delete(@query id: string): EditorProjectDeleteResponse;
}
