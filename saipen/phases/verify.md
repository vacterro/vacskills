# Phase: VERIFY

## VERIFY -- does it work?

Repo's own harness only (never invent one). Strongest available:
parse -> import -> unit -> repro -> smoke.
`verify:` is the minimum. LOG every result.
New nontrivial logic -> repo-style test.
Fixed bug -> regression test that failed pre-fix.
GUI/env unverifiable -> LOG `MANUAL-VERIFY STEPS + EXPECTED`, never fake.
Close with `conf:` -- high (tests green), med (smoke only), low (manual).

## Debug (on FAIL)

Reproduce exactly, quote decisive error line.
Cheap suspects first (git log, config, env, named file).
Hypothesis -> LOG -> test -> fix root cause, not symptom.
Rejected hypotheses stay logged; never re-test without new evidence.
**Cap: 3 dead hypotheses OR 2 failed fix cycles -> mark THIS ticket blocked
on `BOARD.md` with the facts + dead ends, then check for another unblocked
`TODO` ticket and work that instead.** `STATE.phase: BLOCKED` (which loads
`phases/blocked.md` and stops for the user) is reserved for when no other
ticket on the board is workable -- one stuck ticket MUST NOT halt a session
that still has other work available, under `goal_mode` or otherwise.

After VERIFY pass: tick BOARD, next ticket or STATE -> REVIEW.
