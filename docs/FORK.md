# Rosary-mom fork notes

This repository is a public mirror of SpaceXAI's Grok Build harness
([xai-org/grok-build](https://github.com/xai-org/grok-build)), periodically
synced from the monorepo by automation.

## What lives on this branch

The `rosary/power-features` branch (and any merge into `main` you choose) adds
**fork overlay** content that does **not** modify the Rust agent runtime:

| Path | Purpose |
|------|---------|
| [`docs/power-features.md`](power-features.md) | Map of the 24 “must-know” product capabilities → real slash commands and user-guide pages |
| [`docs/for-everyone.md`](for-everyone.md) | Non-technical onboarding (plain language) |
| [`examples/`](../examples/) | Copy-paste agents, personas, workflows, config snippets, and a skill |

Upstream monorepo syncs typically rewrite the crate tree. Keep overlay files under
`docs/` and `examples/` so they are easy to re-apply after a sync.

## Contributing to upstream

Upstream does **not** accept external PRs (see root `CONTRIBUTING.md`). Improve
this fork freely; report security issues via `SECURITY.md`.

## Local install of examples

See [`examples/README.md`](../examples/README.md).
