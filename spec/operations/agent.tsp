using Http;
using OpenAPI;

namespace VidJutsu;

// --- auth.md agentic registration ---
//
// Implements the WorkOS auth.md protocol (https://github.com/workos/auth.md)
// "User-Claimed" flow: the app and user run the OTP ceremony directly, no
// agent-provider participation required. Two entrypoints:
//
//   - `anonymous` — issues a usable API key immediately (pre-claim scopes),
//     plus a claim_token the agent can later exchange for an upgraded
//     credential once the user verifies an email.
//
//   - `verified_email` — kicks off an OTP to the supplied email and returns
//     only a claim_token; no credential is issued until /claim/complete runs.
//
// Discovery routes (.well-known/oauth-protected-resource and
// .well-known/oauth-authorization-server) are hand-registered in convex/http.ts
// and intentionally not part of this generated spec.

// Anonymous signup request body
model AgentSignupAnonymousBody {
  type: "anonymous";
  @doc("Requested credential type. Currently only api_key is supported.")
  requested_credential_type?: "api_key";
}

// Verified email assertion (kicks off OTP flow, returns claim_token)
model AgentSignupVerifiedEmailBody {
  type: "identity_assertion";
  assertion_type: "verified_email";
  @doc("Email address the agent asserts on behalf of the principal.")
  assertion: string;
}

// Note: not using @discriminator because both variants either use
// type="anonymous" or type="identity_assertion" with a single supported
// assertion_type. Server validates the full shape at runtime.
union AgentSignupBody {
  AgentSignupAnonymousBody,
  AgentSignupVerifiedEmailBody,
}

model AgentSignupResponse {
  @doc("Server-generated registration id (rgn_...).")
  registration_id: string;
  @doc("How the registration was initiated.")
  registration_type: "anonymous" | "email-verification";
  @doc("Credential type returned, when issued immediately. Omitted on flows that require claim_token first.")
  credential_type?: "api_key";
  @doc("Live credential (API key) issued by the server, when one is issued immediately.")
  credential?: string;
  @doc("Unix epoch ms when the credential expires, or null/undefined for non-expiring keys.")
  credential_expires?: int64;
  @doc("Scopes the credential is authorized for at issue time.")
  scopes?: string[];
  @doc("Scopes that will be added after the claim flow completes.")
  post_claim_scopes?: string[];
  @doc("URL the agent should direct the principal to in order to complete claim/verification.")
  claim_url?: string;
  @doc("Opaque token used to complete the claim flow.")
  claim_token?: string;
  @doc("Unix epoch ms when the claim_token expires.")
  claim_token_expires?: int64;
}

model AgentClaimRequest {
  @doc("Opaque claim_token returned from the initial /v1/auth/agent call.")
  claim_token: string;
  @doc("Email address to send the verification code to.")
  email: string;
}

model AgentClaimResponse {
  registration_id: string;
  @doc("Identifier for this claim attempt.")
  claim_attempt_id: string;
  status: "initiated";
  @doc("Unix epoch ms when this claim attempt expires.")
  expires_at: int64;
}

model AgentClaimCompleteRequest {
  claim_token: string;
  @doc("6-digit verification code emailed to the principal.")
  code: string;
}

model AgentClaimCompleteResponse {
  @doc("Freshly-rotated API key. For anonymous registrations the original `vj_anon_*` key returned at signup is now invalid; agents MUST replace it with this value.")
  credential: string;
  credential_type: "api_key";
  credential_expires?: int64;
  scopes: string[];
}

model AgentRevokeResponse {
  revoked: boolean;
}

@route("/v1/auth/agent")
@tag("Agent")
interface AgentAuth {
  @post @operationId("signupAgent") @summary("Agent registration (auth.md)")
  @doc("Register a machine client per the auth.md protocol. Two identity types are supported: `anonymous` (returns an API key immediately with pre-claim scopes) and `verified_email` (kicks off OTP, returns only a claim_token). Both flows are user-claimed — the agent and user run the entire ceremony with no agent-provider participation required.")
  @useAuth(NoAuth)
  signup(@body body: AgentSignupBody): AgentSignupResponse;

  @route("/claim")
  @post @operationId("agentClaim") @summary("Initiate claim flow")
  @doc("Initiate the email-verification claim flow for a previously-issued anonymous registration. Sends a 6-digit OTP to the supplied email and returns a claim_attempt_id.")
  @useAuth(NoAuth)
  claim(@body body: AgentClaimRequest): AgentClaimResponse;

  @route("/claim/complete")
  @post @operationId("agentClaimComplete") @summary("Complete claim flow")
  @doc("Complete the email-verification claim flow by submitting the OTP. On success the registration's claimStatus flips to email_verified, post-claim scopes are unlocked, and a freshly-rotated API key is returned. The original pre-claim `vj_anon_*` key is invalidated server-side as a hygiene measure — agents MUST swap it for the new credential.")
  @useAuth(NoAuth)
  claimComplete(@body body: AgentClaimCompleteRequest): AgentClaimCompleteResponse;

  @route("/revoke")
  @post @operationId("agentRevoke") @summary("Revoke credential")
  @doc("Revoke a previously-issued credential. Accepts a logout JWT body (application/logout+jwt) for future provider-driven revocation; currently a no-op receiver, returns 200.")
  @useAuth(NoAuth)
  revoke(@header("content-type") contentType: "application/logout+jwt", @body body: string): AgentRevokeResponse;
}
