# VidJutsu OpenAPI Specification

OpenAPI specification for the [VidJutsu API](https://api.vidjutsu.ai). This is the single source of truth for the API contract — all SDKs, CLIs, docs, and agent skills are generated or validated from this spec.

## Files

```
openapi/spec.json       # Generated OpenAPI 3.0 spec (use this)
spec/                   # TypeSpec source (edit this)
```

## Usage

Reference the spec directly:

```
https://raw.githubusercontent.com/tfcbot/vidjutsu-openapi/main/openapi/spec.json
```

Or install as a dependency:

```bash
npm install tfcbot/vidjutsu-openapi
```

## Building

```bash
npm install
npm run build
```

This compiles the TypeSpec source in `spec/` and outputs `openapi/spec.json`.

## Structure

The TypeSpec source is organized as:

- `spec/main.tsp` — service definition and imports
- `spec/models/` — data types (accounts, posts, tags, errors)
- `spec/operations/` — endpoint definitions grouped by resource
