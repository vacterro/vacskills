---
name: vacskill
description: >
  Cross-agent work protocol. Trigger on "VACSKILL SET", "vacskill", "vac"
  (alias) and their subcommands (set/stop/status/ship/fix/<goal>), when
  resuming earlier work, or in any project containing .vacskill/. Phases
  PLAN → SCOUT → BUILD → VERIFY → REVIEW → SHIP over persistent .vacskill/
  memory: any agent continues another's work without context loss. Load
  STYLE.md with this file (voices); UI.md only for UI work.
---

# vacskill Protocol

Memory owns the project; the model is a temporary worker. Every agent reads
the same `.vacskill/`, continues, writes back. Chat history is not memory.
Cold protocol here — voices in STYLE.md, theme in UI.md.

**Load STYLE.md now, with this file** — its Persistence section keeps the
voice alive past twenty turns. Unreachable (partial copy)? Say so once,
then work facts-only; protocol never waits on style.

## Commands — `vacskill` or short alias `vac`, identical

| Say | Do |
|---|---|
| `VACSKILL SET` / `vacskill set` / `vacskill` | Resume `.vacskill/` (init if none). Board done → HUNT |
| `vacskill <goal>` | Init if needed → PLAN → work |
| `vacskill stop` | Checkpoint + handoff, announce switch phrase |
| `vacskill status` | Report state + metrics (done/blocked, FAIL rate from LOG), change nothing |
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
Legacy `.vac/` instead? Rename it (`git mv` when tracked, plain move
otherwise), LOG one DEC line, continue — never run both. No secrets here:
`.vacskill/` travels with the repo.

**Checkpoint doctrine — write as you go; dying agents get no goodbye turn.**
- Ticket finished → tick BOARD + rewrite STATE `next_action` NOW.
- Run or decision happened → LOG line NOW.
- Before long/risky operation → STATE `next_action` = that operation FIRST.
Worst crash loses one in-flight ticket; `git status` shows even that.

**Backups.** Under git, committed `.vacskill/` IS the backup — any state
returns via `git show <rev>:.vacskill/STATE.md`. No git? Each STATE/BOARD
rewrite first copies the old one to `.vacskill/history/<name>-<DD.MM.YY-
HHmm>.md`, deleting all but the newest 5 of that name in the same breath.

### STATE.md — minimal, read every start

Frontmatter only: `phase` (PLAN|SCOUT|BUILD|VERIFY|REVIEW|SHIP|DONE|
BLOCKED), `task`, `next_action` ("<exact command a cold agent runs first>"),
`blocker`, `agent`, `updated` (ISO — machines check staleness here). Body:
≤3 handoff lines, written only at stop. History → LOG, truth → KNOWLEDGE/.

### BOARD.md — scheduler, not suggestion

```
- [ ] T-005 <verb+object> | files: <paths> | verify: <exact cmd> | needs: T-003 T-004
```
Flags after verify: `[P]` parallel-safe · `ui` · `perf` · `owner: <agent>`.
DONE keeps `(verified: <check> PASS, conf: high|med|low)`.

**Pick rule — no free will:** first DOING; else first TODO whose `needs:`
are all DONE. Board order = priority = law. Reordering = deliberate act:
move the ticket AND log a DEC why. An agent that "prefers" another task is broken.

**Graph mode (several agents):** `needs:` is the DAG. Claim one unblocked
`[P]` ticket: write `owner: <name>` + a LOG claim line, then re-read LOG —
an earlier claim on that ticket beats yours, yield and take the next.
Touch only your ticket's files. Join ticket re-runs full VERIFY after merge.

### LOG.md — journal only

`- <DD.MM.YY HH:mm> [T-###] DEC|RUN|H: <one line, ≤120 chars>`
DEC = decision. RUN = command -> PASS/FAIL + decisive detail. H = hypothesis
-> confirmed/rejected + evidence. Records what HAPPENED, in time order — not
a wiki: durable truth graduates to KNOWLEDGE/ with `DEC: <insight> ->
KNOWLEDGE/<file>`. Voice: STYLE.md.

### KNOWLEDGE/ — durable truth, timeless

```
architecture.md   how the project actually works; update on discovery
conventions.md    naming, patterns, style, user preferences
decisions.md      long-lived choices + why; supersede = edit in place + note
traps.md          bugs that bit, gotchas, flaky zones, env quirks
```
Create each at first real content — no empty placeholders. SCOUT reads
KNOWLEDGE/ before re-scouting: knowledge beats rediscovery. Plain prose.
Past 4 files or ~200 lines → `index.md`: topic → file:line pointers.

## Switch protocol

**Resume** — read STATE + BOARD + LOG tail (~20 lines) + KNOWLEDGE/ file
names (contents on demand). Files changed since `updated` → re-verify claims
first. `updated` < ~15 min AND `agent:` ≠ you → another agent may be live,
confirm takeover with user. Set `agent:`, announce one line `Resume T-003.
Next: <next_action>.`, continue in `phase`.

**Stop** (`vacskill stop`, or ANY low-context signal — warning, compaction,
~80% feel; stop early, never gamble last tokens): empty `.vacskill/tmp/` +
remove debug prints → STATE handoff ≤3 lines + cold-executable
`next_action` → tick BOARD → say `Saved. On any agent: VACSKILL SET`.

**Crash recovery** (died without stop): checkpoints carry it. Newest
evidence wins — LOG tail + first DOING ticket over a stale STATE; `git
status` reveals in-flight edits; re-verify that ticket, finish or reset.

**Init** (no `.vacskill/`): create STATE, BOARD, LOG (KNOWLEDGE/, tmp/ on
first need). Ensure project-root `AGENTS.md` has the block below (search
`VACSKILL:BEGIN` first, never duplicate). `<VACSKILL_HOME>` = absolute folder
of THIS file — resolve when writing. `CLAUDE.md` / `GEMINI.md` missing →
create each: `Read AGENTS.md and obey its vacskill protocol block.`

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

Size gate: **≤2 files + obvious change → skip ceremony: edit, verify, one
LOG line, done.** Otherwise every ticket walks SCOUT → BUILD → VERIFY;
REVIEW guards the wave; SHIP publishes.

**PLAN** — amplify intent ≤8 lines (implied edge cases, callers, migrations,
UI states; safe defaults over interrogation). Cut tickets: one goal each,
independently verifiable, `needs:` for dependencies, board order = execution
order. >10 tickets → waves, detail current wave only. STATE → SCOUT.

**SCOUT** (mandatory before BUILD) — read KNOWLEDGE/ first, then the
ticket's files + ONE similar neighbor: naming, error style, imports, utils,
harness, build commands. The repo already has an architecture — find it,
never invent a parallel one. Durable finding → KNOWLEDGE/. Grep before read.

**BUILD** — smallest safe change, full code: no stubs, no `...`,
null/empty/error paths handled now. Match repo style even if dated;
modernizing = separate ticket. Risky edit → LOG rollback command first.
Scope grows / neighbor broken → new TODO ticket, keep moving. `ui` → UI.md.

**VERIFY — does it work?** Repo's own harness only (package.json / Makefile
/ pytest / cargo / CI — never invent one). Run strongest available: parse →
import → unit → repro → smoke; ticket's `verify:` is the minimum; LOG every
result. New nontrivial logic → test in repo style (happy path + the edge
that bites). Fixed bug → regression test that failed pre-fix. GUI/env
unverifiable → LOG `RUN: MANUAL-VERIFY <steps + expected>`, never fake a
pass. Flaky = flips without code change → find timing/state cause or
quarantine. Close with `conf:` — high = real tests green; med = smoke/import
only; low = MANUAL-VERIFY or env-limited (next agent re-verifies first).

**Debug** (on FAIL) — reproduce exactly, quote one decisive error line →
cheap suspects first (`git log -5 --stat`, config, env, the file the trace
names) → specific hypothesis to LOG → test in reality → fix root cause, not
symptom → repro must PASS. Rejected hypotheses stay logged; never re-test
one without new evidence. **Cap: 3 dead hypotheses OR 2 failed fix cycles →
BLOCKED with facts + dead ends, take next unblocked ticket.**

**REVIEW — is it well made?** On the wave/ship diff (`git diff main...` or
files changed since STATE.updated), not per ticket. Prove each suspicion
with trace/repro before flagging; findings = file:line + what breaks +
failing input:
- **P0 correctness** — broken logic, unhandled paths, off-by-one, races,
  contract breaks, data loss.
- **P1 security** — string-built SQL / `shell=True` / `eval` / HTML
  injection; unnormalized user paths; hardcoded secrets (→ env var + tell
  user to rotate, committed = burned); missing authz siblings have; md5/sha1
  passwords; `npm audit`/`pip-audit` when present.
- **P2 reliability** — silent catches, missing timeouts, leaks, unbounded
  growth. **P3 maintainability** — duplication 3+, dead code, missing tests.
Fix P0/P1 now (back through BUILD+VERIFY); P2/P3 → tickets. Verdict → LOG:
`DEC: SHIP` / `SHIP after <fixes>` / `NO — <blocker>`. **Cap: LOG already
holds a verdict naming this same finding → it survived a pass; verdict `NO`
+ ticket, stop cycling** (the LOG is the counter, not your memory).

**SHIP → PUBLISH** — only when user said `vacskill ship`, or repo has
`origin` AND LOG shows a prior ship; never auto-publish a project that
hasn't opted in. Needs 100% green: blocking tickets DONE, zero unresolved
FAIL, zero open P0/P1. Target = the user's GitHub, never anyone else's.
1. README beautiful every ship: pitch, features, working install, usage,
   screenshot if UI, version + changelog link. Stale README = P1.
2. Version, smallest step: micro → letter `3.1.0a` (docs repos only —
   package managers reject letters); little change → `3.2.1`; feature batch
   → `3.2.0`; breaking → major, rare. Update version file.
3. Before `git add`: .gitignore covers junk + secrets (node_modules,
   __pycache__, dist, .env*, .vacskill/tmp|history/) — missing → write it.
   Empty `.vacskill/tmp/`, strip debug prints.
4. CHANGELOG.md newest-top, 1-2 lines per version = the commit message. Push.
5. Tag it: `git tag -a v<version> -m "<changelog line>"` + `git push origin
   --tags` — any shipped state returns via `git show v<version>:<file>`.
   Tags are the archive; no `_archive_*` copies in the tree.
6. First publish (no origin): confirm name + public/private, `gh repo create
   <name> --source .` (logged-in account); afterwards ship without asking.
7. LOG: `RUN: ship v3.2.1 -> pushed <hash>`.

**HUNT** (bare `vacskill`, board empty/done) — a clean sweep ends with
`RUN: hunt -> clean @<short-hash>` (HEAD then). Skip a sweep only if that
hash == current HEAD and the tree is unmodified; no such line = sweep.
Signal order, cap 5 tickets: failing tests → commits unverified in LOG →
stale TODO/FIXME/HACK → silent failures (empty catch, ignored returns,
missing IO error paths) → symmetry gaps (save/load, undo/redo,
import/export, start/stop) → dead code → orphan files (zero references by
grep, not entry/doc/config). Obvious junk (`__pycache__`, `.DS_Store`,
editor swaps) → delete free; ambiguous → ticket + user confirms. Nothing
found → write the clean line above, report, stop. Never invent busywork.

**Perf** (`perf` flag) — baseline number first (profiler/timer/EXPLAIN →
LOG) → fix top proven bottleneck only → re-measure same way → LOG `<x>% vs
baseline` → gain <20% and uglier → revert + LOG why. Behavior identical.

## Token discipline

- STATE + BOARD full; LOG tail only; KNOWLEDGE on demand. Re-read only
  changed files. Grep before read. Batch independent tool calls.
- Chat report ≤8 lines: done / verified / blocked / next. Quote ≤3 decisive
  output lines. LOG lines ≤120 chars.

## Maintenance (LOG >300 lines, or STATE lies)

Compact LOG in place: keep every DEC, last RUN per task, unresolved FAILs;
collapse repeated PASSes to one line + count; header `# compacted <date>`.
KNOWLEDGE/ never auto-pruned — edit for truth, not size. BOARD DONE >30 →
oldest to `archive.md`. STATE contradicts files → rebuild from BOARD + LOG,
`blocker: "STATE rebuilt <date>, verify"`. Reality wins. **This file too:**
cap ~250 lines — a new rule must evict a stale one. Length is not
thoroughness, it is drift.

## Iron rules

1. Not run = not done. Verify, then report.
2. Board picks the task; the agent does not.
3. `next_action` executable by an agent with zero chat history.
4. Journal ≠ knowledge: LOG events, KNOWLEDGE/ truth.
5. Destructive ops → user confirms unless pre-authorized; publish per SHIP gating.
6. Every loop has a cap; hitting one = BLOCKED + facts, never spinning.
7. Leave no litter; delete only proven-unreferenced or user-confirmed.
8. STYLE.md voice holds to the last response. Corporate prose = drift.
