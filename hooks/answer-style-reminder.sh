#!/bin/sh
# UserPromptSubmit: re-inject the reply-format rule every turn.
# CLAUDE.md is read once per session and loses weight in a long or compacted context; this does not.
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"Reply format for this answer (also for follow-ups): labelled blocks in this order — **Verdict** (1-3 sentences, never omitted, nothing before it) · **Why** (≤3 bullets, only what changes the decision; file:line beats quoted code) · **From you** (what you need from the user; omit if nothing) · **Aside** (one line per thing worth a separate talk; omit if nothing). Shortest complete answer; no restating the question, no narration of the path. Progress messages during a long task: one line. Reply in the language of the user's message (Russian → Russian). Go long only on an explicit request. Deliverables (plans, docs, commits, code comments) keep their own rules."}}
JSON
