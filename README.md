# claude-setup

My personal Claude Code configuration: global rules, hooks, skills and templates. Everything here is
employer-independent and symlinked into `~/.claude` by `install.sh`.

## What's inside

| Path | What it is | Why |
|---|---|---|
| `CLAUDE.md` | Global rules for every project | Reply format with fixed labelled blocks (Verdict / Why / From you / Aside), language rule, how I want agents to work, sensitive-data stop, code-comment and plan rules |
| `hooks/answer-style-reminder.sh` | `UserPromptSubmit` | Re-injects the reply-format rule every turn. `CLAUDE.md` is read once per session and loses weight in a long context; this doesn't |
| `hooks/sensitive-file-guard.sh` | `PreToolUse` / `Read` | Pauses reads of files whose *name* looks like secrets (`.env`, `*.pem`, `credentials`, …) and asks for explicit approval. Name-based on purpose — content matching would fire on every IP in normal code |
| `hooks/perf-review-session-end.sh` | `SessionEnd` | For projects that opt in (`perf-review-track: true` in `CLAUDE.local.md`): distils the session transcript into a performance-review file via a headless `claude -p` call with a $1 budget |
| `skills/english-prompt` | skill | Corrects my English prompt, fills small gaps, appends one record to a learning corpus, then runs the task. Runs on every English message |
| `skills/english-review` | skill | Periodic pass over that corpus: error classes, accuracy per class, CEFR rating with evidence, drills built from my own sentences |
| `skills/before-clear` | skill | Run before `/clear`: walks the session, routes durable facts to auto-memory, open work to plans/backlog, and reports what was saved and what was dropped |
| `skills/perf-review-log` | skill | Merges significant work into one review artifact without turning it into a log |
| `skills/unit-test-writer` | skill | Behaviour-first unit tests, table-driven, mock at boundaries only |
| `skills/split-branch-for-review` | skill (manual only) | Rewrites a squash-merged branch into a sequence a reviewer can read top to bottom |
| `templates/AGENTS.md` + `CLAUDE.local.md` | per-repo template | One tool-agnostic rules file read by Claude Code, Codex and OpenCode |
| `reference/ralphex-roles/` | prompts | Five review roles (implementation, testing, quality, simplification, documentation) usable as subagent prompts in any multi-agent review |
| `reference/task-spec-format.md` | format | Three-section task description: what exists / what to change / resulting scenario and checks |
| `settings.snippet.json` | settings | The hook and skill-override entries to merge into `~/.claude/settings.json` |

Private data (the English corpus, review artifacts) lives outside this repo:
`~/AI/english-learning/`, `~/Work/perf-review/`.

## Install

```bash
git clone <this repo> ~/AI/claude-setup
~/AI/claude-setup/install.sh
# merge settings.snippet.json into ~/.claude/settings.json, then /hooks or restart
```

Check: a reply starts with ▶ **Verdict**; asking to read any `.env` raises the ⛔🚨 banner.

## Design notes

- **Format over length.** The old rule said "be brief" and still produced walls of text I could not
  skim across several parallel sessions. Fixed block labels fix the *reading* problem: the eye lands
  on the same place every time, and a missing label is visible at a glance.
- **Hook, not just a rule.** A style rule in `CLAUDE.md` fades by the middle of a long session. The
  per-turn hook is what keeps it alive.
- **Name-based secret guard.** Content heuristics fire on every hostname in real code; file names are
  a narrow, cheap and good-enough signal.
