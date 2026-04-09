import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";
import "@typespec/rest";

import "./models/common.tsp";
import "./models/accounts.tsp";
import "./models/posts.tsp";
import "./models/assets.tsp";

import "./operations/assets.tsp";
import "./operations/auth.tsp";
import "./operations/accounts.tsp";
import "./operations/posts.tsp";
import "./operations/upload.tsp";
import "./operations/scrape-analyze.tsp";
import "./operations/critic.tsp";
import "./operations/breakdown.tsp";
import "./operations/score.tsp";

using Http;
using OpenAPI;
using Rest;

@service({
  title: "VidJutsu API",
})
@info({
  version: "2026-04-02",
})
@server("https://api.vidjutsu.ai", "Production")
namespace VidJutsu;
