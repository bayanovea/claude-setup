---
name: english-review
description: Periodic review pass over the English-learning corpus. Reads ~/AI/english-learning/corpus.jsonl since the last watermark, updates the error-class journals, computes per-class accuracy rates and trends, rates the user's CEFR level with evidence, and generates drills. Use on /english-review or when the user asks about their English progress, level, or wants exercises.
---

# English Review

The deferred analysis of the corpus that `english-prompt` fills. Here it is fine to be slow and
thorough: this skill is not in the working flow, it is run by hand.

Learning directory: `~/AI/english-learning/`

- `corpus.jsonl` — **source of truth**, append-only, one line per message. Never edit or rewrite it.
- `state.json` — watermark: `{"last_reviewed_ts": "...", "reviews": [...]}`.
- `english-error-classes.md`, `prompt-error-classes.md` — **derived** artifacts. This skill is their
  only writer.
- `mistakes.md` — recurring errors logged by a coach in sessions (ids `E-001`…), with review dates.
  Read it: it is evidence too, and a class that already exists there should not be created twice
  under a new name — reference the `E-` id.
- `progress.md` — history of level ratings and metrics by date.

## 1. Read what is new

Take the `corpus.jsonl` records with `ts > state.last_reviewed_ts`. If there are none, say so and
stop without rewriting anything.

The skill argument can narrow the window (`/english-review last-month`, `/english-review all`) —
use that range, but move the watermark only forward.

## 2. Update the error classes

For each record, file `fixes` into classes in `english-error-classes.md`, and `assumed` / `asked` into
classes in `prompt-error-classes.md`, following the rules in the header of those files:

- Matches an existing class → add the date and a fresh example (keep up to 5, newest first), update
  the **Seen** line.
- A stable new pattern → create a class. A one-off typo (`tag: haste`) does not get a class; it only
  counts in the step-3 statistics.
- A class is a rule that can be drilled with an exercise, not a single error.

## 3. Compute metrics

Count against the **saved `original` texts**, not the number of errors — without a denominator there
is no trend.

For each of the top-3 active classes, count the **opportunities** (how many places in the text the
rule applied) and report accuracy:

- articles — the number of noun phrases that required an article decision;
- questions — the number of interrogative sentences;
- preposition + clause — the number of such junctions;
- likewise for whichever class is currently being drilled.

Plus window totals: words, errors per 100 words, `competence` vs `haste` share, how many messages had
no errors.

**Range growth:** separately note constructions the user used **for the first time and correctly**
(inversion, conditionals, passive, complex subordination, idioms). This is the only thing that shows
B2 → C1 movement; an error counter never will.

## 4. Rate the level

Give a CEFR rating **with a breakdown**, not one letter: range/vocabulary, grammatical accuracy,
communicative effectiveness, ceiling when writing carefully (from the `haste` share). Every number
points at a step-3 metric.

Honesty rules:

- If the window is under ~4 weeks or ~20 messages, say plainly that this is a baseline, not a
  measured trend.
- Compare with the previous `progress.md` entry; call a change a trend only when the **error rate**
  moves, not the absolute count.
- The user writes in a working flow without thinking about language. `haste` errors understate the
  visible level — account for that, but don't excuse systematic things (articles, inversion, verb
  government) as hurry: fluency doesn't produce those.

Append the result to `progress.md`: date, window, metrics, rating, what changed.

## 5. Close the loop

- Class statuses: `active` → `drilling` (exercises issued) → `closed` (zero hits in the last ~200
  opportunities for that class). Blocks are never deleted.
- Issue exercises for **one** class — the top-1 by opportunities with errors, not by absolute hits.
  10–15 items built from the user's **own** sentences in the corpus: this is the IT English they
  actually need, not a textbook.
- Update `state.json`: new `last_reviewed_ts` and a record of the run.

## Boundaries

Don't touch `corpus.jsonl`. Don't hand-edit the class journals outside this skill — the next run
would overwrite the edit. If a journal diverges from the corpus, rebuild it from the corpus, not the
other way round.
