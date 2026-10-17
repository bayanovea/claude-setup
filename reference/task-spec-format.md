# Task description format

A format for tickets and task specs, extracted from a Jira-oriented skill. The tracker is gone; the
format stays — a developer should understand the context, where to change code, and what "done" looks
like, without being handed an implementation plan.

## Gather facts first

1. Read the source docs, the current ticket and the linked ones.
2. Find the real services, files and main functions of the current flow in the code.
3. Don't invent handlers, RPCs or packages. If the change point isn't confirmed, describe it at the
   level of the existing module.

## Three sections, nothing else

```
## What exists now
Short context: where the current code lives and how the scenario runs today. 1–3 paragraphs, name the
service and the main points of the flow, explain the reason for the task in plain words. Not an
architecture overview.

## What to change
3–6 bullets: where to change code (service, directory, file or existing function); what behaviour to
change or add; what explicitly not to change when the boundary matters. Describe required behaviour,
not a step-by-step coding plan. No private function names, no pseudocode, no wiring enumeration, no
estimates unless asked.

## Resulting scenario and verification
One concrete example of input → result. Then 3–5 short checks: the main positive case, a control case
that must not change, compatibility or important parameters preserved. Not a full test matrix.
```

## Parent tasks

Same format. "What exists now" describes the overall problem and service boundaries; "What to change"
lists the child tasks as links with one line of outcome each; the last section describes the state in
which the parent can be closed. Don't copy child details into the parent.

## Decomposition

- One task = one coherent change with one verifiable goal.
- Split when the work touches independent services or clearly exceeds the agreed size.
- Don't split mechanical wiring and tests into separate tasks.
- Use the tracker's hierarchy links for parent/child; don't substitute a "blocks" link for hierarchy.

## Quality gate before submitting

- The description answers "what now", "where and what to fix", "what the result looks like".
- Every path exists or is explicitly marked as new.
- No detailed implementation plan, no filler terminology.
- Parent/child and blocking links are not confused.
