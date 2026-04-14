using Http;
using OpenAPI;

namespace VidJutsu;

model CheckResult {
  rule: string;
  passed: boolean;
  message: string;
  location?: string;
  severity: string;
}

model CheckRequest {
  @doc("VidLang spec JSON to validate")
  spec: Record<unknown>;

  @doc("VidLang rules config. All rules off by default — enable explicitly. E.g. { \"VL013\": true, \"VL003\": false, \"VL011\": { \"severity\": \"warning\" } }")
  rules: Record<unknown>;
}

model CheckResponse {
  passed: boolean;
  results: CheckResult[];
}

model CheckRulesResponse {
  rules: string[];
}

model CheckRulesUpdateRequest {
  rules: string[];
}

@route("/v1/check")
@tag("Check")
interface Check {
  @post @operationId("checkSpec") @summary("Check spec")
  @doc("Validate a VidLang spec against enabled rules. Rules are off by default — caller must enable at least one. 5 credits.")
  check(@body body: CheckRequest): CheckResponse;
}

@route("/v1/check/rules")
@tag("Check")
interface CheckRules {
  @get @operationId("getCheckRules") @summary("Get check rules")
  @doc("Load per-client custom rules. 0 credits.")
  getRules(): CheckRulesResponse;

  @put @operationId("updateCheckRules") @summary("Update check rules")
  @doc("Save per-client custom rules. 0 credits.")
  updateRules(@body body: CheckRulesUpdateRequest): CheckRulesResponse;
}
