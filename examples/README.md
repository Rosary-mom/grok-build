# Examples — put Grok Build’s power features to work

Copy these into your **user** (`~/.grok/…`) or **project** (`.grok/…`) tree.
They do not modify the Rust harness; they configure the installed `grok` binary.

## Quick install (user scope, PowerShell)

From this repository root:

```powershell
$G = Join-Path $env:USERPROFILE ".grok"
New-Item -ItemType Directory -Force -Path "$G\agents","$G\personas","$G\workflows","$G\skills" | Out-Null
Copy-Item examples\agents\* "$G\agents\" -Force
Copy-Item examples\personas\* "$G\personas\" -Force
Copy-Item examples\workflows\* "$G\workflows\" -Force
Copy-Item -Recurse examples\skills\power-features "$G\skills\power-features" -Force
Write-Host "Installed agents, personas, workflows, and /power-features skill under $G"
Write-Host "Optional: merge snippets from examples\config\ into $G\config.toml"
```

**macOS / Linux / Git Bash:**

```sh
G="${HOME}/.grok"
mkdir -p "$G/agents" "$G/personas" "$G/workflows" "$G/skills"
cp examples/agents/* "$G/agents/"
cp examples/personas/* "$G/personas/"
cp examples/workflows/* "$G/workflows/"
cp -R examples/skills/power-features "$G/skills/"
echo "Optional: merge examples/config/*.toml snippets into $G/config.toml"
```

Restart `grok` (or open a new session). Then try:

| Try | What it exercises |
|-----|-------------------|
| `/power-features` | Feature map skill (slash command) |
| `/personas` | See installed personas |
| `/config-agents` | See custom agent definitions |
| `/workflow triage-issues {"root":"."}` | Multi-agent workflow |
| `/workflow codebase-audit {"root":"crates"}` | Read-only audit fan-out |
| `/workflow hermes-office-feature {"goal":"...","root":"examples"}` | Office cycle in the current worktree: plan, investigate, implement, verify |
| `/dashboard` | Multi-session / worktree control |

## Layout

```
examples/
  agents/           Custom agent definitions (.md)
  personas/         Behavioral overlays (.toml)
  workflows/        Multi-agent Rhai orchestration (.rhai)
  config/           Optional config.toml snippets
  sandbox/          Optional sandbox deny patterns
  skills/           Installable skills (SKILL.md)
```

## Project scope (share with a team)

Copy the same trees under the repo’s `.grok/` directory instead of `~/.grok/`.
Project workflows become `/workflow <name>` for everyone who clones the project.

## Official documentation

Full guides: `crates/codegen/xai-grok-pager/docs/user-guide/`.
Power feature map: [`docs/power-features.md`](../docs/power-features.md).
