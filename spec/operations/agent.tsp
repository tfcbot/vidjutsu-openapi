using Http;
using OpenAPI;

namespace VidJutsu;

// --- auth.md agentic registration (PR 4 of credit-billing pivot, 2026-05-23) ---
//
// Implements the WorkOS auth.md protocol (https://github.com/workos/auth.md).
// Three identity types: anonymous, verified_email, identity_assertion (ID-JAG).
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

// ID-JAG (RFC token-type URN). Signed JWT verified against trust list.
model AgentSignupIdJagBody {
  type: "identity_assertion";
  assertion_type: "urn:ietf:params:oauth:token-type:id-jag";
  @doc("Signed identity-assertion JWT (ID-JAG) issued by a trusted assertion provider.")
  assertion: string;
}

// Note: not using @discriminator because two variants share type="identity_assertion"
// and discriminate further on assertion_type. Server validates the full shape at runtime.
union AgentSignupBody {
  AgentSignupAnonymousBody,
  AgentSignupVerifiedEmailBody,
  AgentSignupIdJagBody,
}

model AgentSignupResponse {
  @doc("Server-generated registration id (rgn_...).")
  registration_id: string;
  @doc("How the registration was initiated.")
  registration_type: "anonymous" | "email-verification" | "agentic";
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
  @doc("Register a machine client per the auth.md protocol. Three identity types are supported: `anonymous` (returns an API key immediately with pre-claim scopes), `verified_email` (kicks off OTP, returns a claim_token), and `identity_assertion` with assertion_type=`urn:ietf:params:oauth:token-type:id-jag` (verifies a signed ID-JAG and issues a key bound to the asserted identity).")
  @useAuth(NoAuth)
  signup(@body body: AgentSignupBody): AgentSignupResponse;

  @route("/claim")
  @post @operationId("agentClaim") @summary("Initiate claim flow")
  @doc("Initiate the email-verification claim flow for a previously-issued anonymous registration. Sends a 6-digit OTP to the supplied email and returns a claim_attempt_id.")
  @useAuth(NoAuth)
  claim(@body body: AgentClaimRequest): AgentClaimResponse;

  @route("/claim/complete")
  @post @operationId("agentClaimComplete") @summary("Complete claim flow")
  @doc("Complete the email-verification claim flow by submitting the OTP. On success the registration's claimStatus flips to email_verified, post-claim scopes are unlocked, and an API key credential is returned.")
  @useAuth(NoAuth)
  claimComplete(@body body: AgentClaimCompleteRequest): AgentClaimCompleteResponse;

  @route("/revoke")
  @post @operationId("agentRevoke") @summary("Revoke credential (logout+jwt)")
  @doc("Accept a logout+jwt push from a trusted assertion provider to revoke a previously-issued credential. Body is a signed JWT with media type application/logout+jwt per RFC 8417.")
  @useAuth(NoAuth)
  revoke(@header("content-type") contentType: "application/logout+jwt", @body body: string): AgentRevokeResponse;
}
