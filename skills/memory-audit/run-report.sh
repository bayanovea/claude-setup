#!/bin/bash
# Headless memory audit, launched weekly by launchd; runs only if the last report is 13+ days old.
set -u
OUT="$HOME/.claude/memory-audit"
mkdir -p "$OUT"
last=$(ls -t "$OUT"/*.md 2>/dev/null | head -1)
if [ -n "$last" ] && [ "$(find "$last" -mtime -13)" ]; then
  echo "$(date '+%F %T') skip: last report $(basename "$last") is newer than 13 days"; exit 0
fi
echo "$(date '+%F %T') start"
cd "$HOME" && /opt/homebrew/bin/claude -p "/memory-audit --report" \
  --model sonnet \
  --permission-mode acceptEdits \
  --allowedTools "Read,Edit,Write,Bash(ls:*),Bash(cat:*),Bash(grep:*),Bash(find:*),Bash(head:*),Bash(wc:*),Bash(stat:*),Bash(date:*),Bash(basename:*),Bash(sort:*),Bash(tr:*)" \
  --max-turns 150
echo "$(date '+%F %T') done rc=$?"
