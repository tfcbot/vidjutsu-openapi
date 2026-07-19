using Http;

namespace VidJutsu;

union AgentTaskInputSource {
  url: AgentTaskUrlInput,
  asset: AgentTaskAssetInput,
}

model AgentTaskUrlInput {
  @minLength(1)
  name: string;
  @format("uri")
  url: string;
}

model AgentTaskAssetInput {
  @minLength(1)
  name: string;
  @minLength(1)
  assetId: string;
}

model CreateAgentTaskRequest {
  @minLength(1)
  prompt: string;
  inputs?: AgentTaskInputSource[];
}

enum AgentTaskStatus {
  queued,
  running,
  waitingProvider: "waiting_provider",
  retrying,
  rejected,
  completed,
  failed,
  cancelled,
}

model AgentTaskAccepted {
  id: string;
  status: AgentTaskStatus;
  statusUrl: string;
  eventsUrl: string;
}

model AgentTaskAcceptedResponse {
  @statusCode _: 202;
  @body body: AgentTaskAccepted;
}

enum AgentTaskEventType {
  taskCreated: "task.created",
  agentStarted: "agent.started",
  stageStarted: "stage.started",
  stageCompleted: "stage.completed",
  stageFailed: "stage.failed",
  checkpointCreated: "checkpoint.created",
  providerSubmitted: "provider.submitted",
  taskWaiting: "task.waiting",
  taskRetrying: "task.retrying",
  taskRejected: "task.rejected",
  taskCompleted: "task.completed",
  taskFailed: "task.failed",
  taskCancelled: "task.cancelled",
}

model AgentTaskEvent {
  id: string;
  taskId: string;
  sequence: int32;
  type: AgentTaskEventType;
  data: unknown;
  createdAt: int64;
}

model AgentTaskEventPage {
  taskId: string;
  events: AgentTaskEvent[];
  nextCursor?: string;
  terminal: boolean;
}
