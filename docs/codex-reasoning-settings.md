# Choosing a Codex Reasoning Setting

Reasoning effort is a quality, latency, and token-use tradeoff. The best default
is not the highest available setting; use more reasoning when the task contains
important ambiguity, interacting constraints, or costly failure modes.

## Practical guide

| Setting | Good fit | Examples |
| --- | --- | --- |
| Medium | Clear, bounded work | Small fixes, routine tests, documentation, mechanical refactors |
| High | Normal development work | Feature implementation, debugging across files, code review, integration work |
| XHigh | Difficult design and diagnosis | Architecture, concurrency, data migrations, unfamiliar systems, subtle timing or state problems |
| Max | Rare quality-first checkpoints | High-value design audits, release-risk reviews, or problems where a small reliability gain matters more than latency |

Use **High** as a sensible default for a substantial software project. Drop to
Medium when the task is well specified and easy to verify. Raise to XHigh for a
specific difficult phase. Reserve Max for short, consequential reviews rather
than leaving it enabled for every edit.

## Adjust at phase boundaries

Reasoning effort does not need to stay fixed for an entire project. A useful
pattern is:

1. Design a difficult interface or migration at XHigh.
2. Implement its well-defined pieces at High or Medium.
3. Run tests and collect concrete evidence.
4. Return to XHigh or Max only for a failure-mode or release review.

More reasoning cannot replace tests, fixtures, observability, or a clear success
criterion. If two settings both pass the same representative tasks, prefer the
faster/lower setting. Raise effort when the higher setting produces a measured
improvement, not merely a longer answer.

## Make Codex easier to work with

- Put stable repository instructions and required commands in `AGENTS.md`.
- Turn proven repeatable workflows into Codex skills instead of pasting the same
  large prompt into every task.
- Give long-running work explicit milestones and exit criteria.
- Build evaluation loops: repeat the same representative task, test, or fixture
  when comparing prompts, tools, models, and reasoning settings.
- Keep requests outcome-focused: state the goal, constraints, evidence required,
  and what “done” means.

Official OpenAI guidance recommends Medium as a balanced starting point, High
or XHigh when they show a quality gain, and Max for the hardest quality-first
workloads. It also recommends comparing configurations on representative tasks
instead of assuming the highest effort is automatically best.

References:

- OpenAI model and reasoning guidance: https://developers.openai.com/api/docs/guides/latest-model
- Reusable Codex skills: https://learn.chatgpt.com/use-cases/reusable-codex-skills
- Iterating on difficult problems: https://learn.chatgpt.com/use-cases/iterate-on-difficult-problems
- Following long-running goals: https://learn.chatgpt.com/use-cases/follow-goals
