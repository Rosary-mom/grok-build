<div align="center">

<h1>
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://media.x.ai/v1/website/spacexai-symbol-white-transparent-0c31957f.png">
    <source media="(prefers-color-scheme: light)" srcset="https://media.x.ai/v1/website/spacexai-symbol-black-transparent-6435cf42.png">
    <img alt="SpaceXAI logo" src="https://media.x.ai/v1/website/spacexai-symbol-black-transparent-6435cf42.png" width="96">
  </picture>
  <br>
  Grok Build (<code>grok</code>)
</h1>

**Grok Build** is SpaceXAI's terminal-based AI coding agent. It runs as a
full-screen TUI that understands your codebase, edits files, executes shell
commands, searches the web, and manages long-running tasks — interactively,
headlessly for scripting/CI, or embedded in editors via the Agent Client
Protocol (ACP).

[Installing the released binary](#installing-the-released-binary) ·
[Power features](#power-features) ·
[Building from source](#building-from-source) ·
[Documentation](#documentation) ·
[Examples](#examples-fork-overlay) ·
[Repository layout](#repository-layout) ·
[Development](#development) ·
[Contributing](#contributing) ·
[License](#license)

![Grok Build TUI](https://media.x.ai/v1/website/universe-tui-screenshot-6f7a0837.png)

**Learn more about Grok Build at [x.ai/cli](https://x.ai/cli)** ·
[docs](https://docs.x.ai/build/overview) ·
[changelog](https://x.ai/build/changelog) ·
[open source](https://x.ai/open-source)

This repository contains the Rust source for the `grok` CLI/TUI and its agent
runtime. It is synced periodically from the SpaceXAI monorepo.

A small `SOURCE_REV` file at the root records the full monorepo commit SHA
for the version of the code present in this tree.

> **Rosary-mom fork overlay** — this fork also ships practical docs and
> copy-paste examples under [`docs/`](docs/) and [`examples/`](examples/)
> (worktrees, dashboard, workflows, deep research, goals, personas, and more).
> See [`docs/FORK.md`](docs/FORK.md). They configure the installed `grok`
> binary; they do not replace monorepo syncs of the harness itself.

</div>

---

## Installing the released binary

Prebuilt binaries are published for macOS, Linux, and Windows. **Prefer the
installer** over building from source unless you are changing the harness.

```sh
curl -fsSL https://x.ai/cli/install.sh | bash   # macOS / Linux / Git Bash
irm https://x.ai/cli/install.ps1 | iex          # Windows PowerShell
grok --version
```

On Windows, open a project folder and run `grok` from PowerShell, Windows
Terminal, or your editor’s integrated terminal. First launch opens a browser
for authentication.

See the [changelog](https://x.ai/build/changelog) for the latest fixes,
features, and improvements in each release.

## Power features

Grok Build is no longer “only a chat that edits files.” High-value capabilities
include parallel **git worktrees**, the **Agent Dashboard**, multi-agent
**workflows**, verified **Deep Research**, autonomous **Goal** mode, background
subagents, custom agents/personas, strict **Plan** mode, real **rewind/undo**,
permissions/sandbox, Claude/Cursor/Codex continuity, skills/MCP/plugins/hooks,
voice and media, Mermaid diagrams, web/X search, headless CI (`grok -p`),
`/loop`, cross-session **memory**, multi-machine sessions, ACP, and this
**open-source harness**.

| Start here | What you get |
|------------|----------------|
| [`docs/for-everyone.md`](docs/for-everyone.md) | Plain-language onboarding (non-technical) |
| [`docs/power-features.md`](docs/power-features.md) | All 24 capabilities → slash commands + user-guide links |
| [`examples/`](examples/) | Agents, personas, workflows, config snippets, `/power-features` skill |
| `/tutorial` · `/docs` inside the TUI | Built-in product guides |

Quick tries after install:

```text
/dashboard
/plan describe the change you want
/deep-research <your research question>
/goal <long-running objective>
/workflow codebase-audit {"root":"src"}
/remember a fact you care about later
```

## Building from source

Requirements:

- **Rust** — the toolchain is pinned by [`rust-toolchain.toml`](rust-toolchain.toml);
  `rustup` installs it automatically on first build.
- **[DotSlash](https://dotslash-cli.com)** — required so hermetic tools under
  [`bin/`](bin/) (notably [`bin/protoc`](bin/protoc)) can download and run.
  Install it and ensure `dotslash` is on your `PATH` **before** building:

  ```sh
  cargo install dotslash
  # or: prebuilt packages — https://dotslash-cli.com/docs/installation/
  /usr/bin/env dotslash --help   # sanity check
  ```

- **protoc** — proto codegen resolves [`bin/protoc`](bin/protoc) via DotSlash,
  or falls back to a `protoc` on `PATH` / `$PROTOC`.
- macOS and Linux are supported build hosts; **Windows source builds are
  best-effort** and not currently tested from this tree. On Windows, use the
  [released binary](#installing-the-released-binary) for daily work.

```sh
cargo run -p xai-grok-pager-bin              # build + launch the TUI
cargo build -p xai-grok-pager-bin --release  # release binary: target/release/xai-grok-pager
cargo check -p xai-grok-pager-bin            # fast validation
```

The binary artifact is named `xai-grok-pager`; official installs ship it as
`grok`. On first launch it opens your browser to authenticate — see the
[authentication guide](crates/codegen/xai-grok-pager/docs/user-guide/02-authentication.md).

## Documentation

Full online documentation is available at
[docs.x.ai/build/overview](https://docs.x.ai/build/overview).

The user guide ships with the pager crate:
[`crates/codegen/xai-grok-pager/docs/user-guide/`](crates/codegen/xai-grok-pager/docs/user-guide/)
— getting started, keyboard shortcuts, slash commands, configuration, theming,
MCP servers, skills, plugins, hooks, headless mode, sandboxing, and more.

Fork overlay (this branch / fork):

- [`docs/power-features.md`](docs/power-features.md) — capability → command map
- [`docs/for-everyone.md`](docs/for-everyone.md) — non-technical start
- [`docs/FORK.md`](docs/FORK.md) — how the overlay relates to monorepo syncs

## Examples (fork overlay)

Installable agents, personas, multi-agent workflows, sandbox deny ideas, and a
`/power-features` skill:

→ **[`examples/README.md`](examples/README.md)**

## Repository layout

| Path | Contents |
|------|----------|
| `docs/` | Fork overlay guides (power features, non-technical, fork notes) |
| `examples/` | Copy-paste agents, personas, workflows, config, skills |
| `crates/codegen/xai-grok-pager-bin` | Composition-root package; builds the `xai-grok-pager` binary |
| `crates/codegen/xai-grok-pager` | The TUI: scrollback, prompt, modals, rendering |
| `crates/codegen/xai-grok-shell` | Agent runtime + leader/stdio/headless entry points |
| `crates/codegen/xai-grok-tools` | Tool implementations (terminal, file edit, search, ...) |
| `crates/codegen/xai-grok-workspace` | Host filesystem, VCS, execution, checkpoints |
| `crates/codegen/...` | The rest of the CLI crate closure (config, MCP, markdown, sandbox, ...) |
| `crates/common/`, `crates/build/`, `prod/mc/` | Small shared leaf crates pulled in by the closure |
| `third_party/` | Vendored upstream source (Mermaid diagram stack) — see below |

> [!IMPORTANT]
> The root `Cargo.toml` (workspace members, dependency versions, lints,
> profiles) is **generated** — treat it as read-only. Prefer editing per-crate
> `Cargo.toml` files.

## Development

```sh
cargo check -p <crate>        # always target specific crates; full-workspace builds are slow
cargo test -p xai-grok-config # per-crate tests
cargo clippy -p <crate>       # lint config: clippy.toml at the repo root
cargo fmt --all               # rustfmt.toml at the repo root
```

## Contributing

> [!NOTE]
> External contributions are not accepted. See [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

First-party code in this repository is licensed under the **Apache License,
Version 2.0** — see [`LICENSE`](LICENSE).

Third-party and vendored code remains under its original licenses. See:

- [`THIRD-PARTY-NOTICES`](THIRD-PARTY-NOTICES) — crates.io / git dependencies,
  bundled UI themes, and **in-tree source ports** (including openai/codex and
  sst/opencode tool implementations)
- [`crates/codegen/xai-grok-tools/THIRD_PARTY_NOTICES.md`](crates/codegen/xai-grok-tools/THIRD_PARTY_NOTICES.md)
  — crate-local notice for the codex and opencode ports (license texts +
  Apache §4(b) change notice)
- [`third_party/NOTICE`](third_party/NOTICE) — vendored Mermaid-stack index
