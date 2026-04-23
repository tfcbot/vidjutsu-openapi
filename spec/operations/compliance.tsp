using Http;
using OpenAPI;

namespace VidJutsu;

alias CompliancePlatform = "youtube" | "tiktok" | "instagram" | "facebook-ads";
alias ComplianceFormat = "shortform" | "longform";
alias ComplianceSeverity = "low" | "medium" | "high" | "critical";
alias ComplianceVerdict = "safe" | "caution" | "high-risk" | "likely-violation";

model ComplianceContext {
  caption?: string;
  hashtags?: string[];
  monetized?: boolean;
}

model ComplianceCitation {
  @doc("Exact quoted clause from the platform's policy page.")
  text: string;

  @doc("URL to the source policy page (may include #anchor).")
  sourceUrl: string;

  @doc("ISO date (YYYY-MM-DD) of the policy snapshot this citation was drawn from.")
  policyVersion: string;
}

model ComplianceEvidence {
  @doc("Timestamp (seconds) in the source video where the evidence appears.")
  timestamp?: float64;

  @doc("Relevant transcript excerpt, if any.")
  transcriptExcerpt?: string;

  @doc("Short description of the visual evidence, if any.")
  visualDescription?: string;
}

model ComplianceViolation {
  @doc("Stable identifier of the matched rule in our compliance corpus.")
  ruleId: string;

  @doc("Rule category, e.g. monetization, community-guidelines, ad-policy, copyright, minors.")
  category: string;

  severity: ComplianceSeverity;

  @doc("Plain-language reasoning tying the video to the cited rule. Informational, not legal advice.")
  explanation: string;

  citation: ComplianceCitation;
  evidence: ComplianceEvidence;
}

model ComplianceVideoRequest {
  @doc("Public URL of the video to scan.")
  videoUrl: string;

  platform: CompliancePlatform;

  @doc("Optional content format hint. Inferred from duration when omitted.")
  format?: ComplianceFormat;

  @doc("Optional publication metadata that affects risk (caption, hashtags, monetization intent).")
  context?: ComplianceContext;
}

alias CompliancePromptKind = "caption" | "script" | "ad-copy" | "description" | "other";

model CompliancePromptRequest {
  @doc("The text to evaluate — caption, ad copy, draft script, upload description, etc.")
  text: string;

  platform: CompliancePlatform;

  @doc("Optional label for logs; does not affect rule selection.")
  kind?: CompliancePromptKind;

  @doc("Optional publication metadata that affects risk (caption, hashtags, monetization intent).")
  context?: ComplianceContext;
}

model ComplianceCheckResponse {
  @doc("Composite risk score 0-100 computed deterministically from violation severities.")
  riskScore: int32;

  verdict: ComplianceVerdict;

  violations: ComplianceViolation[];

  platform: CompliancePlatform;

  @doc("ISO date of the newest active policy snapshot this scan was evaluated against.")
  policySnapshotDate: string;

  @doc("Informational disclaimer. This response is not legal advice.")
  disclaimer: string;
}

@route("/v1/compliance")
@tag("Compliance")
interface Compliance {
  @route("/video")
  @post @operationId("checkComplianceVideo") @summary("Check video compliance")
  @doc("Scan a video against a platform's current TOS / Community Guidelines. Returns a risk score with cited policy clauses. Informational only, not legal advice. 20/day rate limit.")
  video(@body body: ComplianceVideoRequest): ComplianceCheckResponse;

  @route("/prompt")
  @post @operationId("checkCompliancePrompt") @summary("Check prompt compliance")
  @doc("Scan a caption, ad copy, draft script, or other text against a platform's current TOS / Community Guidelines. Returns a risk score with cited policy clauses. Informational only, not legal advice. 100/day rate limit.")
  prompt(@body body: CompliancePromptRequest): ComplianceCheckResponse;
}
