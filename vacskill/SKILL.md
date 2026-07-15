---
name: vacskill
description: >
  Cross-agent work protocol. Trigger on "VACSKILL SET", "vacskill set",
  "vacskill", "vacskill <goal>", "vacskill stop", "vacskill status",
  "vacskill ship", "vacskill fix <symptom>" (short alias "vac" works for
  every command), when resuming earlier work, or any multi-step task in a
  project containing .vacskill/. Phases PLAN → SCOUT → BUILD → VERIFY →
  REVIEW → SHIP over persistent .vacskill/ memory: any agent (Claude Code,
  OpenCode, Codex, Gemini, others) continues another agent's work without
  context loss. Companions next to this file: STYLE.md (writing voices —
  load together with this), UI.md (load only for UI work).
---

# vacskill Protocol

Memory owns the project; the model is a temporary worker. Every agent
reads the same `.vacskill/`, continues, writes back. Chat history is not
memory. This file is cold protocol — voices live in STYLE.md, theme in
UI.md.

## Commands

Every command takes `vacskill` or the short alias `vac` — identical
meaning, pick either.

| Say | Do |
|---|---|
| `VACSKILL SET` / `vacskill set` / `vacskill` | Resume `.vacskill/` (init if none). Board done → HUNT |
| `vacskill <goal>` | Init if needed → PLAN → work |
| `vacskill stop` | Checkpoint + handoff, announce switch phrase |
| `vacskill status` | Report state + quick metrics (done/blocked, FAIL rate from LOG), change nothing |
| `vacskill ship` | REVIEW gate → green → PUBLISH |
| `vacskill fix <symptom>` | Straight to VERIFY/debug |

## Memory — `.vacskill/` at project root

```
STATE.md     rewrite   position only: phase, task, next_action, blocker
BOARD.md     rewrite   tickets: TODO / DOING / DONE — the scheduler
LOG.md       append    journal: what happened, one line per event
KNOWLEDGE/   edit      durable truth; files created on first real content
tmp/         scratch   disposable; never committed, gone by stop/ship
```

Legacy `.vac/` found instead? Rename it (`git mv .vac .vacskill`), LOG one
DEC line, continue. Never run both.

**Checkpoint doctrine — write as you go; dying agents get no goodbye turn.**
- Ticket finished → tick BOARD + rewrite STATE `next_action` NOW.
- Run or decision happened → LOG line NOW.
- Before long/risky operation → STATE `next_action` = that operation FIRST.
Worst crash loses one in-flight ticket; `git status` shows even that.
Never store secrets in `.vacskill/` — it travels with the repo.

### STATE.md — minimal, read every start

Frontmatter only: `phase` (PLAN|SCOUT|BUILD|VERIFY|REVIEW|SHIP|DONE|
BLOCKED), `task`, `next_action` ("<exact command a cold agent runs
first>"), `blocker`, `agent`, `updated` (ISO — machines check staleness
here). Body: ≤3 handoff lines, written only at stop. History lives in LOG,
knowledge in KNOWLEDGE/ — never here.

### BOARD.md — scheduler, not suggestion

```
- [ ] T-005 <verb+object> | files: <paths> | verify: <exact cmd> | needs: T-003 T-004
```
Flags after verify: `[P]` parallel-safe · `ui` (UI.md applies) · `perf` ·
`owner: <agent>` (parallel work). DONE keeps `(verified: <check> PASS)`.

**Pick rule — no free will:** take first DOING; else first TODO whose
`needs:` are all DONE. Board order = priority = law. Reordering is a
deliberate act: move the ticket AND log a DEC line why. An agent that
"prefers" another task first is broken.

**Graph mode (several agents at once):** `needs:` forms the DAG. Each
agent claims one unblocked `[P]` ticket by writing `owner: <name>` on it +
a LOG claim line; first claim in LOG wins conflicts. Work only your
ticket's files; checkpoint normally. A join ticket (`needs:` all branches)
re-runs full VERIFY after merge.

### LOG.md — journal only

`- <DD.MM.YY HH:mm> [T-###] DEC|RUN|H: <one line, ≤120 chars>`
DEC = decision. RUN = command -> PASS/FAIL + decisive detail. H =
hypothesis -> confirmed/rejected + evidence. LOG records what HAPPENED, in
time order. It is not a wiki: durable truth graduates to KNOWLEDGE/ with a
pointer line `DEC: <insight> -> KNOWLEDGE/<file>`. Voice: STYLE.md.

### KNOWLEDGE/ — durable truth, timeless

```
architecture.md   how the project actually works; update on discovery
conventions.md    naming, patterns, style, user preferences
decisions.md      long-lived choices + why; supersede = edit in place + note
traps.md          bugs that bit, gotchas, flaky zones, env quirks
```
Create each file at first real content — no empty placeholders. SCOUT
reads KNOWLEDGE/ before re-scouting the repo: knowledge is cheaper than
rediscovery. Plain professional prose (STYLE.md). Past 4 files or any file
~200 lines → add `index.md`: topic → file:line pointers.

## Switch protocol

**Resume** (`VACSKILL SET`/`vacskill`/`vac`): read STATE + BOARD + LOG
tail (~20 lines) + KNOWLEDGE/ file names (contents on demand). Files
changed since `updated` → re-verify claims before building on them.
`updated` < ~15 min AND `agent:` ≠ you → another agent may be live;
confirm takeover with user. Set `agent:`, announce one line
`Resume T-003. Next: <next_action>.`, continue in `phase`.

**Stop** (`vacskill stop`, or ANY low-context signal — platform warning,
compaction, ~80% feel; stop early, never gamble last tokens): empty
`.vacskill/tmp/` + remove your debug prints → STATE handoff ≤3 lines +
cold-executable `next_action` → tick BOARD → say
`Saved. On any agent: VACSKILL SET`.

**Crash recovery** (died without stop): checkpoints carry it. STATE stale
but LOG/BOARD newer → trust LOG tail + first DOING ticket; `git status`
reveals in-flight edits; re-verify that ticket, finish or reset it.

**Init** (no `.vacskill/`): create STATE, BOARD, LOG (KNOWLEDGE/ and tmp/
on first need). Ensure project-root `AGENTS.md` contains the block below
(search `VACSKILL:BEGIN` first, never duplicate). `<VACSKILL_HOME>` =
absolute folder of THIS file — resolve when writing. `CLAUDE.md` /
`GEMINI.md` missing → create each: `Read AGENTS.md and obey its vacskill
protocol block.`

```md
<!-- VACSKILL:BEGIN -->
## vacskill protocol (any agent)
Memory: .vacskill/ here. Read .vacskill/STATE.md before work; checkpoint as you go.
On "VACSKILL SET": read <VACSKILL_HOME>/SKILL.md + <VACSKILL_HOME>/STYLE.md.
Path missing (new machine)? clone github.com/vacterro/vacskill.
UI work: also obey <VACSKILL_HOME>/UI.md.
<!-- VACSKILL:END -->
```

## Phases

Size gate first: **≤2 files + obvious change → skip ceremony: edit,
verify, one LOG line, done.** Otherwise every ticket walks
SCOUT → BUILD → VERIFY; REVIEW guards the wave; SHIP publishes.

**PLAN** — amplify intent ≤8 lines (implied edge cases, callers,
migrations, UI states; safe defaults over interrogation). Cut tickets:
one goal each, independently verifiable, `needs:` for dependencies,
board order = execution order. >10 tickets → waves; detail current wave
only, re-plan between waves. STATE → SCOUT, `next_action` = T-001.

**SCOUT** (per ticket, mandatory before BUILD) — read KNOWLEDGE/ first,
then the ticket's files + ONE similar neighbor: naming, error style,
imports, utils, test harness, build commands. The repo already has an
architecture — find it, never invent a parallel one. New durable finding →
KNOWLEDGE/. Cheap: grep before read, named files only, not the tree.

**BUILD** — smallest safe change, full code: no stubs, no `...`,
null/empty/error paths handled now. Match repo style even if dated;
modernizing = separate ticket. Risky edit → LOG rollback command first.
Scope grows / neighbor broken → new TODO ticket, keep moving. `ui` flag →
apply UI.md, non-negotiable.

**VERIFY — does it work?** Repo's own harness only (package.json /
Makefile / pytest / cargo / CI — never invent one). Run strongest
available: parse → import → unit → repro → smoke; ticket's `verify:` is
the minimum; LOG every result. New nontrivial logic → test in repo style
(happy path + the edge that bites). Fixed bug → regression test that
failed pre-fix. GUI/env unverifiable → LOG `RUN: MANUAL-VERIFY <steps +
expected>`, never fake a pass. Flaky = flips without code change → find
timing/state cause or quarantine ticket; never green on retry-luck.
Close with confidence: `(verified: <check> PASS, conf: high|med|low)` —
high = real tests green; med = smoke/import only; low = MANUAL-VERIFY or
env-limited. Low conf → next agent re-verifies before building on it.

**Debug** (on FAIL) — reproduce exactly, quote one decisive error line →
cheap suspects first (`git log -5 --stat`, config, env, the file the
trace names) → specific hypothesis to LOG → test in reality → fix root
cause, not symptom → repro must PASS. Rejected hypotheses stay logged;
never re-test one without new evidence. **Caps: 3 dead hypotheses OR 2
failed fix cycles on one ticket → BLOCKED with facts + dead ends, take
next unblocked ticket.**

**REVIEW — is it well made?** Runs on the wave/ship diff (`git diff
main...` or files changed since STATE.updated), not per ticket. Verify
each suspicion with trace/repro before flagging; findings = file:line +
what breaks + failing input:
- **P0 correctness** — broken logic, unhandled paths, off-by-one, races,
  contract breaks, data loss.
- **P1 security** — string-built SQL / `shell=True` / `eval` / HTML
  injection; unnormalized user paths; hardcoded secrets (found → env var +
  tell user to rotate, committed = burned); missing authz siblings have;
  md5/sha1 for passwords; `npm audit`/`pip-audit` when present.
- **P2 reliability** — silent catches, missing timeouts, leaks, unbounded
  growth. **P3 maintainability** — duplication 3+, dead code, missing tests.
Fix P0/P1 now (back through BUILD+VERIFY); P2/P3 → tickets. **Cap: same
finding survives 2 review passes → verdict `NO — <blocker>` + ticket, stop
cycling.** Verdict → LOG: `DEC: SHIP` / `SHIP after <fixes>` / `NO`.

**SHIP → PUBLISH** — only when user said `vacskill ship`, or repo has an
`origin` remote AND LOG shows a prior ship. NEVER auto-publish a project
that hasn't opted in. Requires 100% green: blocking tickets DONE, zero
unresolved FAIL, zero open P0/P1. Target = the user's GitHub, never
anyone else's.
1. README beautiful every ship: title + one-line pitch, features, install
   that works, usage, screenshot if UI, version + changelog link. Stale
   README = P1.
2. Version bump, smallest step: micro → letter `3.1.0a` (docs repos only —
   package-manager repos use plain patch); little change → `3.2.1`;
   feature batch → `3.2.0`; breaking → major, rare. Update version file.
3. Before `git add`: .gitignore covers junk + secrets (node_modules,
   __pycache__, dist, .env*, .vacskill/tmp/) — missing → write it first.
   Empty `.vacskill/tmp/`, strip debug prints.
4. CHANGELOG.md newest-top, 1-2 lines per version. Commit message = that
   line. Push to `origin`.
5. First publish (no origin): confirm repo name + public/private with
   user, `gh repo create <name> --source .` (lands under logged-in gh
   account); afterwards ship without asking.
6. LOG: `RUN: ship v3.2.1 -> pushed <hash>`.

**HUNT** (bare `vacskill`, board empty/done) — skip if last LOG hunt was
clean AND `git status` unchanged: say clean, stop. Else sweep in signal
order, cap 5 tickets: failing tests → recent commits unverified in LOG →
stale TODO/FIXME/HACK → silent failures (empty catch, ignored returns,
missing IO error paths) → symmetry gaps (save/load, undo/redo,
import/export, start/stop) → dead code → orphan files (zero references by
grep, not entry/doc/config). Obvious junk (`__pycache__`, `.DS_Store`,
editor swaps) → delete free; ambiguous → ticket + user confirms. Never
invent busywork.

**Perf** (`perf` flag) — baseline number first (profiler/timer/EXPLAIN →
LOG) → fix top proven bottleneck only → re-measure same way → LOG `<x>%
vs baseline` → gain <20% and uglier → revert + LOG why. Behavior identical.

## Token discipline

- Read STATE + BOARD full; LOG tail only; KNOWLEDGE file on demand.
  Re-read only changed files. Grep before read.
- Batch independent tool calls. One verify command beats three.
- Chat report ≤8 lines: done / verified / blocked / next. Quote ≤3 output
  lines — the decisive ones.
- LOG lines ≤120 chars.

## Maintenance (LOG >300 lines, or STATE lies)

Compact LOG in place: keep every DEC, last RUN per task, unresolved FAILs;
collapse repeated PASSes to one line + count; header `# compacted <date>`.
KNOWLEDGE/ is never auto-pruned — edit for truth, not size. BOARD DONE >30
→ oldest to `archive.md`. STATE contradicts files → rebuild from BOARD +
LOG, set `blocker: "STATE rebuilt <date>, verify"`. Reality wins.

## Iron rules

1. Verify before report. Not run = not done.
2. Checkpoints are part of the work, not paperwork after it.
3. `next_action` executable by an agent with zero chat history.
4. Board picks the task; the agent does not. Journal ≠ knowledge:
   LOG records events, KNOWLEDGE/ records truth.
5. Destructive ops (delete, force-push, schema drop) → user confirms
   unless ticket pre-authorizes. Publishing → only per SHIP gating.
6. Every loop has a cap; hitting a cap = BLOCKED + facts, never spinning.
7. Leave no litter: scratch in `.vacskill/tmp/`, gone by stop/ship;
   orphans deleted only proven-unreferenced or user-confirmed.
8. Cooperative handoffs: facts + warnings; next agent never guesses.
