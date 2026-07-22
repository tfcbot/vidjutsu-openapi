import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "@typespec/rest";

import "./models/common.tsp";
import "./models/accounts.tsp";
import "./models/posts.tsp";
import "./models/assets.tsp";
import "./models/references.tsp";
import "./models/editorProjects.tsp";
import "./models/scrape.tsp";
import "./models/downloads.tsp";
import "./models/cloning.tsp";

import "./operations/assets.tsp";
import "./operations/editorProjects.tsp";
import "./operations/scrape.tsp";
import "./operations/downloads.tsp";
import "./operations/auth.tsp";
import "./operations/accounts.tsp";
import "./operations/posts.tsp";
import "./operations/references.tsp";
import "./operations/upload.tsp";
import "./operations/watch.tsp";
import "./operations/extract.tsp";
import "./operations/transcribe.tsp";
import "./operations/check.tsp";
import "./operations/compliance.tsp";
import "./operations/overlay.tsp";
import "./operations/disclaimer.tsp";
import "./operations/agent.tsp";
import "./operations/cloning.tsp";

using Http;
using OpenAPI;
using Rest;

@service({
  title: "VidJutsu API",
})
@info({
  version: "2026-07-22",
})
@server("https://api.vidjutsu.ai", "Production")
@useAuth(BearerAuth)
@doc("VidJutsu is a video API built for agents to operate directly. Your agent can clone viral trending skits now: stage a trending clip with /v1/videos/download/tiktok or /v1/videos/download/instagram, check it for cloneability, generate a character and a clean starting frame, then render the clone. Kling 3.0 Motion Control is the supported clone-video model and preserves the source soundtrack.")
@tagMetadata(
  "Cloning",
  #{
    description: "Your agent can Clone Viral Trending Skits Now. These endpoints check whether a staged source video is worth cloning, generate the character and starting frame, and render and poll the final clone video.",
  }
)
namespace VidJutsu;

model BearerAuth is Http.BearerAuth;
