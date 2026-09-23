# Grok Build — power features map (v1.x)

Grok Build moved from a terminal coding assistant to a full agentic engineering
platform in under twelve weeks (v0.1 → v1.0). This page maps the **most
important product capabilities** to **commands and in-repo docs** so you can use
them without hunting.

Official guides ship under
[`crates/codegen/xai-grok-pager/docs/user-guide/`](../crates/codegen/xai-grok-pager/docs/user-guide/).
Online: [docs.x.ai/build](https://docs.x.ai/build/overview) ·
[changelog](https://x.ai/build/changelog) · [install](https://x.ai/build).

---

## At a glance

| # | Capability | Jump in with | Deep dive |
|---|------------|--------------|-----------|
| 1 | Parallel work via **Git worktrees** | Dashboard dispatch · `/fork --worktree` · `isolation: worktree` | [17-sessions](../crates/codegen/xai-grok-pager/docs/user-guide/17-sessions.md) · [23-dashboard](../crates/codegen/xai-grok-pager/docs/user-guide/23-dashboard.md) |
| 2 | **Agent Dashboard** | `/dashboard` · aliases `/agents-dashboard`, `/sessions` | [23-dashboard](../crates/codegen/xai-grok-pager/docs/user-guide/23-dashboard.md) |
| 3 | **Multi-agent workflows** | `/workflow` · `/workflows` · `.grok/workflows/*.rhai` | [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) · [examples/workflows](../examples/workflows/) |
| 4 | **Deep Research** (verified claims) | `/deep-research <question>` | [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) |
| 5 | **Goal mode** (autonomous objectives) | `/goal …` · `status` / `pause` / `resume` / `clear` | [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) |
| 6 | **Background** subagents & commands | Subagents default background · `Ctrl+B` · tasks pane | [16-subagents](../crates/codegen/xai-grok-pager/docs/user-guide/16-subagents.md) · [20-background-tasks](../crates/codegen/xai-grok-pager/docs/user-guide/20-background-tasks.md) |
| 7 | **Custom agents & personas** | `/config-agents` · `/personas` · `.grok/agents/` · `.grok/personas/` | [16-subagents](../crates/codegen/xai-grok-pager/docs/user-guide/16-subagents.md) · [examples/](../examples/) |
| 8 | **Plan mode** (edit only the plan file) | `/plan` · `/view-plan` · `Shift+Tab` | [19-plan-mode](../crates/codegen/xai-grok-pager/docs/user-guide/19-plan-mode.md) |
| 9 | **Q&A before wrong direction** | Agent `ask_user_question` cards · Tab through answers | [19-plan-mode](../crates/codegen/xai-grok-pager/docs/user-guide/19-plan-mode.md) |
| 10 | **Rewind / undo** (chat + files) | `/rewind` · `/undo` | [17-sessions](../crates/codegen/xai-grok-pager/docs/user-guide/17-sessions.md) |
| 11 | **Permissions & sandbox** | `/always-approve` · `/auto` · sandbox profiles · path denies | [22-permissions](../crates/codegen/xai-grok-pager/docs/user-guide/22-permissions-and-safety.md) · [18-sandbox](../crates/codegen/xai-grok-pager/docs/user-guide/18-sandbox.md) |
| 12 | **Claude / Cursor / Codex continuity** | Welcome screen sessions · `/import-claude` · `grok inspect` | [01-getting-started](../crates/codegen/xai-grok-pager/docs/user-guide/01-getting-started.md) · [12-project-rules](../crates/codegen/xai-grok-pager/docs/user-guide/12-project-rules.md) |
| 13 | **Skills, MCP, plugins, hooks** | `/skills` · `/mcps` · `/plugins` · `/hooks` · `/skillify` | [07](../crates/codegen/xai-grok-pager/docs/user-guide/07-mcp-servers.md)–[10](../crates/codegen/xai-grok-pager/docs/user-guide/10-hooks.md) · [08-skills](../crates/codegen/xai-grok-pager/docs/user-guide/08-skills.md) |
| 14 | **Collaborate while working** | Queued prompts · interject · `/btw` · edit earlier message | [03-keyboard-shortcuts](../crates/codegen/xai-grok-pager/docs/user-guide/03-keyboard-shortcuts.md) |
| 15 | **Voice, images, documents, media** | `Ctrl+Space` / `F8` · paste images · `/imagine` · PDF/PPTX tools | [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) |
| 16 | **Native Mermaid diagrams** | Diagrams render in TUI / plan preview | [19-plan-mode](../crates/codegen/xai-grok-pager/docs/user-guide/19-plan-mode.md) |
| 17 | **Web search & X search** | Built-in tools; subagents can inherit | tools + [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) |
| 18 | **Headless / CI** | `grok -p` · JSON / streaming · subagents wait | [14-headless-mode](../crates/codegen/xai-grok-pager/docs/user-guide/14-headless-mode.md) |
| 19 | **Recurring loops** | `/loop 30m …` | [20-background-tasks](../crates/codegen/xai-grok-pager/docs/user-guide/20-background-tasks.md) |
| 20 | **Persistent memory** | `/remember` always · `/memory` `/flush` `/dream` (experimental) | [13-memory](../crates/codegen/xai-grok-pager/docs/user-guide/13-memory.md) |
| 21 | **Long sessions & multi-machine** | `/resume` · `/compact` · `/timeline` · `/jump` · remote restore | [17-sessions](../crates/codegen/xai-grok-pager/docs/user-guide/17-sessions.md) |
| 22 | **Daily utilities** | `/code-review` · `/docs` · `/tutorial` · `/doctor` · `/effort` · `/history` · `/delete` | [04-slash-commands](../crates/codegen/xai-grok-pager/docs/user-guide/04-slash-commands.md) |
| 23 | **ACP** (drive from other apps) | `grok agent stdio` | [15-agent-mode](../crates/codegen/xai-grok-pager/docs/user-guide/15-agent-mode.md) |
| 24 | **Open-source harness** | This repo — agent loop, tools, TUI, skills, MCP, hooks | [README](../README.md) · [x.ai/open-source](https://x.ai/open-source) |

---

## Recipes that combine features

### A. Parallel feature + bugfix + tests

1. Open `/dashboard`.
2. Dispatch agents into **worktrees** (or `/fork --worktree` with a clear directive).
3. Give each agent one job: implement / reproduce / write tests / alternate design.
4. Review diffs per worktree; apply or discard intentionally.
5. If an approach fails: `/undo` in that session.

### B. Large PR or whole-repo review

1. Save or copy a workflow under `.grok/workflows/` (see [examples/workflows](../examples/workflows/)).
2. Run `/workflow review-changes {"target":"origin/main...HEAD"}`, or `/workflow hermes-office-feature {"goal":"...","root":"examples"}` from a git worktree.
3. Watch phases and agents in `/workflows`.
4. Prefer workflows that **adversarially verify** findings before the final report.

### C. Research you can trust

```
/deep-research Compare the migration risks of PostgreSQL 17 and MySQL 9
```

- Runs in the background; main session stays free.
- Claims are independently verified; failed shards produce a **Partial** report, not false certainty.
- Follow progress with `/workflows`.

### D. Multi-hour engineering objective

```
/goal Migrate the auth module to the new API --budget 500000
/goal status
```

Completion is not “the agent says done” — an **independent evidence review** must pass.

### E. Capture a winning process

After a session that worked well:

```
/skillify
```

Turn the approach into a reusable skill (and optionally a slash command via
`user-invocable: true`).

### F. CI / automation

```sh
grok -p "Review the diff and report blockers as JSON" --output-format json
```

See [14-headless-mode](../crates/codegen/xai-grok-pager/docs/user-guide/14-headless-mode.md)
for schemas, streaming, costs, and waiting on delegated work.

---

## Safety checklist (use with power features)

- Prefer **Plan mode** for refactors, schema changes, and security-sensitive work.
- Keep **Always Allow** globs narrow; use **Never Allow** for destructive shells.
- Deny credential globs (`**/*.pem`, `**/*credentials*`, `.env` secrets).
- Require **folder trust** for unfamiliar directories.
- Expand full bash bodies (`Ctrl-F`) before approving long scripts.
- Use `read-only` / `read-write` / `execute` capability modes on subagents.

---

## Examples and local skill

| Install | Path |
|---------|------|
| This fork’s examples | [examples/README.md](../examples/README.md) |
| Power-features skill (slash `/power-features`) | [examples/skills/power-features/](../examples/skills/power-features/) |

Non-technical start: [for-everyone.md](for-everyone.md).
