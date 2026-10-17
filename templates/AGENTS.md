# AGENTS.md — <project> (tool-agnostic: read by Claude Code, Codex and OpenCode)

<!--
Template. Copy to the repo root, fill the <...> parts, delete sections that don't apply.
Pair it with a one-line CLAUDE.local.md containing `@AGENTS.md` so every agent reads the same file.
If this is someone else's repo, add both files to .git/info/exclude.
-->

## 🚨 Sensitive data — STOP and get my explicit, conscious approval

Before reading, opening, grepping, printing or otherwise surfacing content that looks like it contains
any of the following, HALT and ask me first with a loud banner (a line of ⛔/🚨 and the word **ALARM**).
Do not proceed until I confirm in this session:

- personal or confidential data (real people's PII, private user data);
- private correspondence (messages, email threads, chat logs);
- passwords, tokens, API keys, private keys, certificates, other secrets;
- financial information;
- internal policies or confidential company documents.

<!-- If hostnames / internal URLs are pervasive in this codebase, say so here: reading them is fine,
     copying them into anything that leaves this machine is not. -->

When unsure whether something is sensitive, treat it as sensitive and ask.

## Language & code conventions

- <language and version, e.g. Go 1.25>
- Keep the code simple, compact and easy to read. No clever, over-engineered or unnecessarily abstract solutions.
- <project-specific: pointer rules, nil-check policy, error wrapping, lint config>

## Tests

- Always try to write unit tests. If the existing code has no tests, ask whether tests should be added.
- Do not write mock-heavy tests for metrics or the logger; use an empty namespace and a no-op logger.
- <how to run them: `make test`, `go test ./...`>

## How I want you to work

- Split work across subagents when the task allows it; reuse an agent that already has the context.
- Bugs: find the first place where the wrong state appears; compare fixes by blast radius; choose the
  earliest correct abstraction level. Don't change global logic for a narrow edge case.
- Keep intermediate conclusions and final outputs brief.

## Generated code

- Never write generated files by hand. Use the dedicated commands: <`go generate`, `make gen`, …>.

## Related repositories

- <sibling repos with schemas / contracts, where they live, what not to commit there>
