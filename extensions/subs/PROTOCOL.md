# SubSaipen Protocol

Isolated, read-only agents that research the main project in parallel and
hand back structured findings -- never a second write-path into the
project. Extension, not Core (RFC § 1.9): nothing here is read by the
SAIPEN home on its own behalf, and it never relaxes what Core requires.

## 0. Root path

Single root: **`.saipen/extensions/subs/`**, inside the project's `.saipen/` (v7.35.0; a project bootstrapped before then MAY still carry this at root-level `extensions/subs/` -- equivalent, migrate when convenient).

```
.saipen/extensions/subs/
├── MANIFEST.md            # list of active subSaipen names
├── PROTOCOL.md             # this file
├── _shared/
│   └── inbox.md            # non-critical findings, reviewed next round
├── TEMPLATE/                # copy this to start a new subSaipen
│   ├── STATE.md
│   ├── BOARD.md
│   ├── LOG.md
│   └── kitchen/
│       └── OUTBOX.md
└── <name>/                  # one folder per subSaipen (saiwiki, saihunt, ...)
    ├── STATE.md
    ├── BOARD.md
    ├── LOG.md
    └── kitchen/
        ├── OUTBOX.md
        └── _*.md            # scratch, ignored by the main agent
```

## 1. What a subSaipen is

A subSaipen is a normal SAIPEN instance -- same `STATE.md`/`BOARD.md`/`LOG.md`
shape, same `phase` enum (RFC § 1.6), same LOG skeleton (RFC § 1.2) -- living
in its own folder instead of the project's `.saipen/`, permanently locked to
`mode: read-only`. No separate state machine, no lifecycle field: RFC § 1.3
already defines exactly the behavior wanted here -- "the agent MAY still
read, analyze, and report; it advises, it does not act" -- MUST NOT
transition to `BUILD`/`SHIP`/`CLEAN`/`TRANSLATE`, MUST NOT touch any file
outside its own `.saipen/extensions/subs/<name>/`. This is a *policy* use of the
same `mode: read-only` value Core defines for a *capability* gap (missing
filesystem write) -- the behavioral contract is identical either way, so
the value is reused deliberately, not coincidentally.

**Enforcement is procedural, same footing as RFC § 1.1's destructive-op
rule** -- there is no universal technical lock. The subSaipen's own
instructions (this file) are the contract; if the platform running it
offers real isolation (a separate working directory, a git worktree scoped
to `.saipen/extensions/subs/<name>/`), use it. Don't claim automated enforcement
that isn't there.

## 2. OUTBOX format

File: `<name>/kitchen/OUTBOX.md`. The only channel back to the main agent.

```markdown
# OUTBOX

## WIKI-001: short description
- **status:** ready | draft | blocked
- **summary:** one line, what was found or produced
- **main_project_refs:** [src/foo.py, ...]
- **critical:** true | false
- **details:**
  What was found, what's proposed, why it matters.
```

| Status | Meaning |
|---|---|
| `ready` | Done, main agent may act on it |
| `draft` | Still in progress, main agent ignores |
| `blocked` | Waiting on something external, reason in `details` |

`critical: true` = bug, broken behavior, data loss, security issue.
`critical: false` = improvement, docs, refactor, cosmetic.

## 3. Ticket ID namespace

| Prefix | Owner |
|---|---|
| `SYS-` | Cross-cutting / protocol-level tickets |
| `WIKI-` | saiwiki |
| `HUNT-` | saihunt |
| `<NAME>-` | any other subSaipen (first 4 letters, uppercase) |

Each subSaipen numbers its own tickets independently; the prefix is what
keeps them unambiguous once folded into the main board.

## 4. Handoff

**Main agent -> subSaipen**: writes tickets into `<name>/BOARD.md`'s
`## TODO`. The subSaipen reads its own board, picks the next ticket, same
Pick Rule as Core (RFC § 1.6).

**SubSaipen -> main agent**: finishes a ticket, writes the result into
`kitchen/OUTBOX.md` as `status: ready`, moves the ticket to its own
`## DONE`. Whenever the main agent chooses to check (during `HUNT`, at
the top of `saipen continue`, or via `saipen sub collect`):
1. Read every active subSaipen's `OUTBOX.md`.
2. For each `ready` entry: `critical: true` -> ticket on the main
   `BOARD.md` immediately; `critical: false` -> append to
   `_shared/inbox.md` for the next planning round.
3. Clear the entry from `OUTBOX.md` (or mark it reviewed) and append one
   `RUN:` line to the *main* `LOG.md` naming what happened to it --
   folding a subSaipen's finding into the project is exactly the kind of
   event `LOG.md` exists to record.

No ACK ceremony, no timers, no lifecycle states -- this is a manually
invoked agent, not a daemon; nothing here needs liveness detection.

## 5. MANIFEST.md

File: `.saipen/extensions/subs/MANIFEST.md`. Just the list of subSaipen the main
agent should remember to check -- their own `STATE.md` already carries
`phase`/`task`/`next_action`, no need to duplicate it here.

```markdown
# SubSaipen Manifest

- saiwiki -- .saipen/extensions/subs/saiwiki/
- saihunt -- .saipen/extensions/subs/saihunt/
```

Add a line on `spawn`, remove it on `clean`. That's the whole lifecycle.

## 6. Staleness

A subSaipen that's finished and folded in is stale kitchen content by
definition (RFC § 1.2's kitchen rule, `phases/clean.md`) -- `HUNT`'s
existing kitchen-staleness check (v7.23.0) already covers it. No separate
staleness machinery needed here.

## 7. `saipen sub` commands (extension-defined, RFC § 1.9)

Legal only while `.saipen/extensions/subs/` (or legacy root `extensions/subs/`) exists in the project.

| Command | Does |
|---|---|
| `saipen sub list` | Read `MANIFEST.md`; for each entry, read its `STATE.md` and report `phase`/`task`. |
| `saipen sub spawn <name>` | **First-run bootstrap, then spawn.** If this project has no `.saipen/extensions/subs/` yet: copy `PROTOCOL.md`, `README.md`, `TEMPLATE/`, and an empty `_shared/inbox.md` from `<saipen_home>/extensions/subs/` (the SAIPEN home's own copy of this extension -- unaffected by where a consuming project attaches it; the home path is already in `STATE.md`'s `saipen_home` field, RFC § 1.7 -- no manual copy needed, this IS the explicit ask that makes copying it in appropriate, unlike `saipen set`'s general no-auto-populate rule in RFC § 1.9). Then, every run: copy `TEMPLATE/` to `.saipen/extensions/subs/<name>/`, set `agent: <name>` in its `STATE.md`, add a line to `MANIFEST.md` (creating it first if this was also the bootstrap run). |
| `saipen sub collect` | Run the Handoff procedure (§ 4) against every active subSaipen. |
| `saipen sub clean <name>` | Remove the `MANIFEST.md` line and the `.saipen/extensions/subs/<name>/` folder -- only once its `BOARD.md` is empty and its `OUTBOX.md` has nothing `ready` left unreviewed. |

`saipen sub spawn` requires a project that already has `.saipen/` (i.e. `saipen set` already ran) -- a subSaipen attaches to a main project's continuation state, it isn't one on its own. No `.saipen/` at all yet? Tell the user to run `saipen set` first; don't silently trigger `INIT` as a side effect of an unrelated command.

First `saipen sub spawn` in a project no `saipen_home` was ever recorded for (state written before v7.25.0, or a manual/degraded bootstrap)? Ask once -- `WAIT: path to the saipen clone to bootstrap subs from` -- never guess a path.

## 8. File shape for a subSaipen

Identical to Core's own `.saipen/` shape (RFC § 1.2) -- `phase`, `task`,
`next_action`, `blocker`, `agent`, `saipen_version`, `mode` (always
`read-only`), `updated`. No extra required fields. If this file and
RFC.md ever disagree on the shared shape, RFC.md wins (RFC § 1.9).
