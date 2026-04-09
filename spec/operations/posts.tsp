using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/posts")
@tag("Posts")
interface Posts {
  @post @operationId("createPost") @summary("Create draft post")
  create(@body body: PostCreateRequest): {
    @statusCode _: 201;
    @body body: PostCreateResponse;
  };

  @put @operationId("updatePost") @summary("Update draft post")
  update(@query id: string, @body body: PostUpdateRequest): PostUpdateResponse;

  @get @operationId("listOrGetPosts") @summary("List posts or get by ID")
  @doc("Returns a single post if ?id= is provided, or a list of posts. Filter by ?accountId= or ?tag.key=value.")
  list(@query id?: string, @query accountId?: string): Post | PostListResponse;

  @delete @operationId("deletePost") @summary("Cancel post")
  delete(@query id: string): PostDeleteResponse;
}
