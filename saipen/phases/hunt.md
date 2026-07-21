# Phase: HUNT (board empty/done)

Clean sweep. Skip only if LOG has `hunt -> clean @HASH` matching current HEAD.

**Subagents available (RFC § 1.3)?** Dispatch the 6 signal categories below
as one batch of parallel subagent tasks instead of scanning them in turn.
Each subagent is read-only: it investigates and returns findings, it MUST
NOT touch `.saipen/` itself -- only the orchestrating agent writes BOARD/LOG,
once, after merging every subagent's results. This avoids write races by
construction. No subagent support -> run the same 6 categories sequentially,
exactly as below. Either path, the cap and output are identical.

Signal order, cap 5 tickets:
1. Failing tests
2. Commits unverified in LOG
3. Stale TODO/FIXME/HACK
4. Silent failures (empty catch, ignored returns, missing IO error paths)
5. Symmetry gaps (save/load, undo/redo, import/export, start/stop)
6. Dead code, orphan files (zero grep refs, not entry/doc/config)

Obvious junk -> delete free, capped at 5 files per sweep (same cap as the
ambiguous tickets above), and never user data (anything a user created or
would recognize as their own work -- same floor `phases/clean.md` states
explicitly). More than that in one pass is mass-deletion territory (RFC
§ 1.1) regardless of how obvious each file looks individually -- ticket
the rest for confirmation instead of free-deleting past the cap.

`.saipen/kitchen/` is in scope for this sweep too, not just orphan code --
use `phases/clean.md`'s stale definition (owning ticket `DONE` and off
`BOARD.md`, or content fully superseded by `LOG.md`/`CHANGELOG.md`). This
is what actually keeps kitchen/ bounded: `CLEAN` only runs when a user
explicitly asks for it, `HUNT` runs every autonomous pass with no tasking
required, so a kitchen file can't outlive its usefulness for more than one
maintenance cycle.

Ambiguous -> ticket + user confirms.
Findings ticketed (not clean)? STATE -> `PLAN` (or straight to `SCOUT` if
a finding is small/obvious enough to skip planning, same judgment call as
`phases/plan.md`'s size gate) -- work them same as any other `TODO`, board
order = priority.
Nothing found -> LOG one normal Event Graph line per RFC § 1.2 -- `- DATE
[E-###] [parent: E-###] RUN: hunt -> clean @SHORT-HASH` (this exact text
after the taxonomy, not a free-text summary) -- then immediately
transition to `ADD`. This transition is unconditional -- a clean hunt is
never itself a reason to stop, under `goal_mode` or otherwise (RFC § 2.4).
Never invent busywork.

## Perf (user asks specifically, or a ticket calls for it)

Baseline number first (profiler/timer/EXPLAIN -> LOG).
Fix top proven bottleneck -> re-measure same way.
Gain under 20% and uglier -> revert + LOG why.