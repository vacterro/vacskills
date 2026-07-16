---
name: vacskill
description: >
  Cross-agent work protocol. Trigger on "VACSKILL SET", "vacskill", "vac"
  (alias) and subcommands (set/stop/status/ship/fix/GOAL), on resuming
  earlier work, or in any project containing .vacskill/. Phases PLAN →
  SCOUT → BUILD → VERIFY → REVIEW → SHIP over persistent .vacskill/ memory:
  any agent continues another's work without context loss. Load STYLE.md
  with this file (voice); UI.md only for UI work.
---

# vacskill

Memory owns the project; the model is a temporary worker. Agents read the
same `.vacskill/`, continue, write back. Chat history is not memory.
**Load STYLE.md with this file.** Unreachable? Say so once, work facts-only;
protocol never waits on style. UI work → UI.md too.

## Commands — `vacskill` / `vac`, identical

| Say | Do |
|---|---|
| `VACSKILL SET` / `vacskill` | Resume `.vacskill/` (init if none). Board done → HUNT |
| `vacskill GOAL` | Init if needed → PLAN → work |
| `vacskill stop` | Checkpoint + handoff, announce switch phrase |
| `vacskill status` | Report state + metrics (done/blocked, FAIL rate), change nothing |
| `vacskill ship` | REVIEW gate → green → PUBLISH |
| `vacskill fix SYMPTOM` | Straight to VERIFY/debug |

## Memory — `.vacskill/` at project root

```
STATE.md     rewrite   phase, task, next_action, blocker
BOARD.md     rewrite   TODO / DOING / DONE — the scheduler
LOG.md       append    journal, one line per event
KNOWLEDGE/   edit      durable truth, at first real content
tmp/         scratch   empty by stop/ship
```
All files **UTF-8 plain text (no BOM)** — never via UTF-16-defaulting
redirects (PowerShell `>`, `Out-File`; use `-Encoding utf8`). Found UTF-16 →
convert, LOG a DEC line. Legacy `.vac/` → rename (`git mv` when tracked),
LOG a DEC line, never run both. No secrets — travels with the repo.

**Checkpoint — write as you go; dying agents get no goodbye turn.** Ticket
done → tick BOARD + rewrite STATE `next_action` NOW. Run/decision → LOG line
NOW. Before a long/risky op → STATE `next_action` = that op FIRST.

**Backups.** Git: committed `.vacskill/` IS the backup (`git show
REV:.vacskill/STATE.md`). No git → before rewriting STATE/BOARD, copy old to
`.vacskill/history/NAME-DD.MM.YY-HHmm.md`, keep newest 5.

### STATE.md — read every start

Frontmatter only: `phase` (PLAN|SCOUT|BUILD|VERIFY|REVIEW|SHIP|DONE|BLOCKED),
`task`, `next_action` (exact command a cold agent runs first), `blocker`,
`agent`, `updated` (ISO). Body ≤3 handoff lines, at stop only. History →
LOG, truth → KNOWLEDGE/.

### BOARD.md — scheduler, not suggestion

```
- [ ] T-005 VERB+OBJECT | files: PATHS | verify: EXACT CMD | needs: T-003 T-004
```
Flags: `[P]` parallel-safe · `ui` · `perf` · `owner: NAME`. DONE keeps
`(verified: CHECK PASS, conf: high|med|low)` — **DONE without it is not
DONE: reopen or re-verify.**

**Pick rule:** first DOING; else first TODO whose `needs:` are all DONE.
Board order = priority = law. Reorder = move ticket + LOG a DEC why. Never
"prefer" another task.

**Graph mode:** `needs:` is the DAG. Claim one unblocked `[P]`: write
`owner: NAME` + LOG claim line, re-read LOG — earlier claim wins, yield.
Touch only your ticket's files. Join ticket re-runs VERIFY after merge.

### LOG.md — journal only

`- DD.MM.YY HH:mm [T-###] DEC|RUN|H: ONE LINE ≤120 CHARS`
DEC = decision. RUN = command -> PASS/FAIL + decisive detail. H = hypothesis
-> confirmed/rejected + evidence. Events in time order, not a wiki — durable
truth graduates: `DEC: INSIGHT -> KNOWLEDGE/FILE`.

### KNOWLEDGE/ — durable truth

`architecture.md` how it works · `conventions.md` patterns, prefs ·
`decisions.md` choices + why (supersede = edit + note) · `traps.md` bugs,
gotchas, env quirks. Create at first real content — no placeholders. SCOUT
reads it before re-scouting. Past 4 files or ~200 lines → `index.md`: topic
→ file:line.

## Switch

**Resume** — read STATE + BOARD + LOG tail (~20 lines) + KNOWLEDGE/ file
names (contents on demand). Files changed since `updated` → re-verify claims
first. User asks "is it fixed?" → trust evidence, not checkboxes: re-run the
ticket's `verify:` before confirming. `updated` under ~15 min AND `agent:` ≠
you → another agent may be live; confirm takeover. Set `agent:`, announce
`Resume T-003. Next: NEXT_ACTION.`, continue in `phase`.

**Stop** (`vacskill stop`, or ANY low-context signal — warning, compaction,
~80% feel; stop early, never gamble last tokens): empty `tmp/`, remove debug
prints → STATE handoff ≤3 lines + cold-executable `next_action` → tick BOARD
→ say `Saved. On any agent: VACSKILL SET`.

**Crash recovery** — newest evidence wins: LOG tail + first DOING over stale
STATE; `git status` reveals in-flight edits; re-verify that ticket, finish or
reset.

**Init** (no `.vacskill/`) — create STATE, BOARD, LOG (KNOWLEDGE/, tmp/ on
first need). Ensure root `AGENTS.md` has the block below (search
`VACSKILL:BEGIN`, never duplicate). `VACSKILL_HOME` = absolute folder of
THIS file. `CLAUDE.md`/`GEMINI.md` missing → create each: `Read AGENTS.md
and obey its vacskill protocol block.`

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

**Size gate:** ≤2 files + obvious change → edit, verify, one LOG line, done.
Else every ticket walks SCOUT → BUILD → VERIFY; REVIEW guards the wave; SHIP
publishes.

**PLAN** — amplify intent ≤8 lines (edge cases, callers, migrations, UI
states; safe defaults over interrogation). Tickets: one goal, independently
verifiable, `needs:` for dependencies, board order = execution order. >10 →
waves, detail current wave only. STATE → SCOUT.

**SCOUT** (mandatory before BUILD) — KNOWLEDGE/ first, then the ticket's
files + ONE similar neighbor: naming, error style, imports, utils, harness,
build commands. The repo has an architecture — find it, never invent a
parallel one. Durable finding → KNOWLEDGE/. Grep before read.

**BUILD** — smallest safe change, full code: no stubs, null/empty/error paths
handled now. Match repo style even if dated; modernizing = separate ticket.
Risky edit → LOG rollback command first. Scope grows / neighbor broken → new
TODO ticket, keep moving. `ui` → UI.md.

**VERIFY — does it work?** Repo's own harness only (package.json / Makefile /
pytest / cargo / CI — never invent one). Strongest available: parse → import
→ unit → repro → smoke; `verify:` is the minimum; LOG every result. New
nontrivial logic → repo-style test (happy path + the edge that bites). Fixed
bug → regression test that failed pre-fix. GUI/env unverifiable → LOG
`RUN: MANUAL-VERIFY STEPS + EXPECTED`, never fake a pass. Flaky (flips
without code change) → find timing/state cause or quarantine. Close with
`conf:` — high = tests green; med = smoke/import only; low = MANUAL-VERIFY
(next agent re-verifies first).

**Debug** (on FAIL) — reproduce exactly, quote one decisive error line →
cheap suspects first (`git log -5 --stat`, config, env, the file the trace
names) → hypothesis to LOG → test it → fix root cause, not symptom → repro
must PASS. Rejected hypotheses stay logged; never re-test without new
evidence. **Cap: 3 dead hypotheses OR 2 failed fix cycles → BLOCKED with
facts + dead ends, take next unblocked ticket.**

**REVIEW — is it well made?** On the wave/ship diff (`git diff main...` or
files changed since STATE.updated), not per ticket. Prove suspicions with
trace/repro; findings = file:line + what breaks + failing input:
- **P0 correctness** — broken logic, unhandled paths, off-by-one, races, contract breaks, data loss.
- **P1 security** — string-built SQL / `shell=True` / `eval` / HTML injection; unnormalized user paths; hardcoded secrets (→ env var, tell user to rotate; committed = burned); missing authz siblings have; md5/sha1 passwords; `npm audit`/`pip-audit` when present.
- **P2 reliability** — silent catches, missing timeouts, leaks, unbounded growth. **P3** — duplication 3+, dead code, missing tests.
Fix P0/P1 now (BUILD+VERIFY); P2/P3 → tickets. Verdict → LOG: `DEC: SHIP` /
`SHIP after FIXES` / `NO — BLOCKER`. **Cap: LOG already holds a verdict on
this finding → `NO` + ticket, stop cycling.**

**SHIP → PUBLISH** — only on `vacskill ship`, or repo has `origin` AND LOG
shows a prior ship; never auto-publish an unopted project. Needs 100% green:
blocking tickets DONE, zero unresolved FAIL, zero open P0/P1. Target = the
user's GitHub only.
1. README beautiful every ship: pitch, features, working install, usage, screenshot if UI, version + changelog link. Stale README = P1.
2. Version, smallest step: micro → letter `3.1.0a` (docs repos only); little change → `3.2.1`; feature batch → `3.2.0`; breaking → major, rare. Update version file.
3. Before `git add`: .gitignore covers junk + secrets (node_modules, __pycache__, dist, .env*, .vacskill/tmp|history/) — missing → write it. Empty `tmp/`, strip debug prints.
4. CHANGELOG.md newest-top, 1-2 lines per version = the commit message. Push.
5. `git tag -a vVERSION -m "CHANGELOG LINE"` + `git push origin --tags`. Tags are the archive; no `_archive_*` copies.
6. First publish (no origin): confirm name + public/private, `gh repo create NAME --source .`; afterwards ship without asking.
7. LOG: `RUN: ship v3.2.1 -> pushed HASH`.

**HUNT** (bare `vacskill`, board empty/done) — clean sweep ends with
`RUN: hunt -> clean @SHORT-HASH` (HEAD then); skip only if that hash ==
current HEAD, tree unmodified. Signal order, cap 5 tickets: failing tests →
commits unverified in LOG → stale TODO/FIXME/HACK → silent failures (empty
catch, ignored returns, missing IO error paths) → symmetry gaps (save/load,
undo/redo, import/export, start/stop) → dead code → orphan files (zero grep
refs, not entry/doc/config). Obvious junk (`__pycache__`, `.DS_Store`, editor
swaps) → delete free; ambiguous → ticket + user confirms. Nothing found →
clean line, report, stop. Never invent busywork.

**Perf** (`perf` flag) — baseline number first (profiler/timer/EXPLAIN →
LOG) → fix top proven bottleneck → re-measure same way → LOG `X% vs
baseline` → gain under 20% and uglier → revert + LOG why. Behavior identical.

## Token discipline

STATE + BOARD full; LOG tail only; KNOWLEDGE/ on demand. Re-read only changed
files. Grep before read. Batch independent tool calls. Chat report ≤8 lines:
done / verified / blocked / next. Quote ≤3 decisive output lines.

## Maintenance (LOG >300 lines, or STATE lies)

Compact LOG in place: keep every DEC, last RUN per task, unresolved FAILs;
collapse repeated PASSes to one line + count; header `# compacted DATE`.
KNOWLEDGE/ never auto-pruned — edit for truth, not size. BOARD DONE >30 →
oldest to `archive.md`. STATE contradicts files → rebuild from BOARD + LOG,
`blocker: "STATE rebuilt DATE, verify"`. Reality wins. This file too: a new
rule evicts a stale one.

## Iron rules

1. Not run = not done. Verify, then report.
2. Board picks the task; the agent does not.
3. `next_action` executable by an agent with zero chat history.
4. Journal ≠ knowledge: LOG events, KNOWLEDGE/ truth.
5. Destructive ops → user confirms unless pre-authorized; publish per SHIP gating.
6. Every loop has a cap; hitting one = BLOCKED + facts, never spinning.
7. Leave no litter; delete only proven-unreferenced or user-confirmed.
8. `.vacskill/` files stay UTF-8 plain text — unreadable memory is no memory.
9. STYLE.md voice holds to the last response. Corporate prose = drift.
