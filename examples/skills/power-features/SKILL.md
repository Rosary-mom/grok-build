---
name: power-features
description: >
  Map and operate Grok Build’s most important product capabilities: worktrees,
  dashboard, workflows, deep research, goals, background agents, personas, plan
  mode, rewind, sandbox, Claude/Cursor/Codex import, skills/MCP/hooks, voice and
  media, headless CI, loops, memory, ACP, and the open-source harness. Use when
  the user asks what Grok Build can do, how to use power features, or runs
  /power-features.
metadata:
  short-description: "Grok Build power features map"
user-invocable: true
---

# Grok Build power features

When invoked, give a **short, practical** orientation (not a wall of marketing).
Prefer commands the user can type **now**. Link deeper docs when useful.

## Core map (use as checklist)

1. **Worktrees** — parallel agents without stomping files: `/dashboard` dispatch, `/fork --worktree`, subagent `isolation: worktree`.
2. **Agent Dashboard** — `/dashboard` (aliases `/agents-dashboard`, `/sessions`): model, mode, branch, activity, per-turn summary.
3. **Workflows** — `/workflow <name> {…}`, live board `/workflows`, scripts in `.grok/workflows/*.rhai` or `~/.grok/workflows/`.
4. **Deep Research** — `/deep-research <question>`; verified claims; Partial when shards fail.
5. **Goal mode** — `/goal <objective>`; `status` | `pause` | `resume` | `clear`; independent evidence review.
6. **Background work** — subagents background by default; `Ctrl+B` demotes a command; tasks pane.
7. **Agents & personas** — `/config-agents`, `/personas`; capability modes `read-only` | `read-write` | `execute` | `all`.
8. **Plan mode** — `/plan`; only the plan file is editable until approval; Mermaid in plan preview.
9. **Q&A cards** — answer multiple-choice before implementation when ambiguous.
10. **Rewind** — `/rewind` / `/undo` restores conversation **and** file state.
11. **Permissions & sandbox** — `/auto`, `/always-approve`, Never Allow, free-form Always Allow globs, path denies, full script expand `Ctrl-F`.
12. **Other tools continuity** — resume Claude/Cursor/Codex sessions; `/import-claude`; AGENTS.md.
13. **Extensibility** — `/skills`, `/mcps`, `/plugins`, `/hooks`, `/skillify`.
14. **Live collaboration** — queue prompts while working; `/btw` side questions; edit & resubmit earlier messages.
15. **Multimodal** — voice `Ctrl+Space`/`F8`; paste images; PDF/PPTX; `/imagine`, video tools.
16. **Mermaid** — native diagrams in TUI / plans.
17. **Web + X search** — parent and subagents can research in parallel.
18. **Headless** — `grok -p` for CI, JSON schema output, subagents, costs.
19. **Loops** — `/loop 30m …` with stop conditions.
20. **Memory** — `/remember` always; `/memory` `/flush` `/dream` when experimental memory is on.
21. **Long continuity** — `/resume`, `/compact`, `/timeline`, `/jump`, multi-machine restore.
22. **Daily utils** — `/code-review`, `/docs`, `/tutorial`, `/doctor`, `/effort`, `/history`, `/delete`, `/recap`.
23. **ACP** — `grok agent stdio` for editors and hosts.
24. **Open harness** — this source tree is the agent loop + TUI (Apache-2.0 first-party).

## Response style

- Start with 3–5 **recommended next commands** for the user’s stated goal.
- Offer a recipe: Plan → implement → verify → `/skillify` if the process was good.
- If they want installable samples, point at the repo `examples/` tree or their `~/.grok` copies.
- Never claim a feature is unavailable if the installed slash menu shows it; if unsure, suggest `/docs` or `/release-notes`.

## Safety reminder (always include once)

Plan mode + narrow Always Allow + secret path denies + `/undo` make aggressive automation safe enough to experiment.
