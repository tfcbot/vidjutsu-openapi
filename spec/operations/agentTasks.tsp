using Http;
using OpenAPI;

namespace VidJutsu;

@route("/v1/agent/tasks")
@tag("Agent Tasks")
interface AgentTasks {
  @post @operationId("createAgentTask") @summary("Create an asynchronous agent media task")
  create(
    @header("Idempotency-Key") idempotencyKey: string,
    @body body: CreateAgentTaskRequest,
  ): AgentTaskAcceptedResponse | SubscriptionRequiredResponse | RateLimitedResponse;
}

@route("/v1/agent/tasks/events")
@tag("Agent Tasks")
interface AgentTaskEvents {
  @get @operationId("listAgentTaskEvents") @summary("Tail structured agent task events")
  list(
    @query id: string,
    @query after?: string,
    @query limit?: int32,
  ): AgentTaskEventPage | SubscriptionRequiredResponse;
}
