# Grok Build for everyone

You do not need to be a professional developer to get value from Grok Build.
This page uses plain language. When you are ready for technical detail, open
[`power-features.md`](power-features.md) or type `/docs` / `/tutorial` inside
the app.

## What is Grok Build?

Grok Build is an AI assistant that lives in a terminal (or can run quietly in
the background). It can:

- Read and edit project files
- Run safe commands when you allow them
- Search the web and X
- Work on long goals across many steps
- Split work across several AI helpers at once

Think of it as a junior engineer sitting next to you — not a magic button that
always guesses correctly.

## Install (one minute)

**Windows (PowerShell):**

```powershell
irm https://x.ai/cli/install.ps1 | iex
grok --version
```

**macOS / Linux / WSL:**

```sh
curl -fsSL https://x.ai/cli/install.sh | bash
grok --version
```

Then open a folder for your work and start:

```sh
cd path/to/your/project
grok
```

The first time, it opens a browser so you can sign in.

## First day — safe habits

1. **Ask before big changes.** Type `/plan` and describe what you want. Review
   the plan, then approve.
2. **Say when you are unsure.** Grok can show multiple-choice questions instead
   of guessing wrong. Answer them.
3. **Use undo.** If a change looks wrong: `/undo` (same as `/rewind`) restores
   an earlier conversation *and* file state.
4. **Protect secrets.** Do not paste passwords or API keys into the chat. Block
   sensitive files (for example `**/*.pem`) in permissions/sandbox settings.
5. **Side questions.** While Grok is working, `/btw how does login work?` asks
   a side question without killing the main task.

## Everyday power moves (still simple)

| Goal | What to type |
|------|----------------|
| Long multi-step job | `/goal Migrate the contact form replies to the new template` |
| Serious research with fact-check | `/deep-research Compare …` then watch `/workflows` |
| Many agents at once | Open `/dashboard` (or press the agents shortcut) |
| Save a fact for next week | `/remember staging uses eu-west` |
| Repeat until done | `/loop 15m check if the site is up` |
| Catch up after a long session | `/recap` or `/summarize` |

## When something feels stuck

- `/doctor` — diagnoses terminal, clipboard, and related issues
- `/docs` — built-in how-to guides
- `/tutorial` — short onboarding topics
- `/feedback` — send a report to the product team

## Next steps

- **Feature map (all 24 capabilities):** [power-features.md](power-features.md)
- **Copy-paste examples:** [../examples/README.md](../examples/README.md)
- **Official docs:** https://docs.x.ai/build/overview
