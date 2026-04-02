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

@route("/v1/posts/schedule")
@tag("Posts")
interface PostSchedule {
  @post @operationId("schedulePost") @summary("Schedule draft post")
  schedule(@body body: PostScheduleRequest): {
    @statusCode _: 202;
    @body body: PostScheduleResponse;
  };
}

@route("/v1/posts/assign")
@tag("Posts")
interface PostAssign {
  @post @operationId("assignPost") @summary("Assign draft post to account")
  assign(@body body: PostAssignRequest): PostAssignResponse;
}

@route("/v1/posts/duplicate")
@tag("Posts")
interface PostDuplicate {
  @post @operationId("duplicatePost") @summary("Duplicate a post")
  duplicate(@body body: PostDuplicateRequest): {
    @statusCode _: 201;
    @body body: PostDuplicateResponse;
  };
}
