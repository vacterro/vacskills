# Phase: CLEAN (triggered by `saipen clean`)

Deep repository scrub. Execute strictly in order.

**Safety floor, applies to every step below:** CLEAN MUST NOT delete user data
(anything the user created or would recognize as their own work) without
explicit confirmation -- "obviously safe to remove" (§1/§2/§4 below) means
scaffolding, cache, and orphaned build artifacts, never something a user
might have meant to keep. If any step turns out unsafe to complete --
ambiguous ownership, a deletion candidate that might be load-bearing,
anything CLEAN can't confidently reason about -- STOP that step, ticket it
for human review same as an ambiguous orphan (§2), and if that leaves the
repository in a state CLEAN can't safely finish auditing, transition
`STATE.phase: BLOCKED` instead of pushing through. CLEAN returns `DONE` only
when it actually finished safely, not by default.

1. **Board Scrub:** 
   - Remove `[x]` DONE tasks from `BOARD.md` that are older than the current active work. This prunes `BOARD.md`, not history -- every one of those tickets' real events (created, built, verified, shipped) already lives permanently in `LOG.md`'s append-only graph; nothing is lost, just no longer cluttering the active board.
   - Prune stale or abandoned `TODO` tickets.
   - Re-check every `## BLOCKED` ticket: blocker resolved elsewhere since it
     landed there? Move it back to `## TODO`. Still stuck and genuinely
     abandoned? Prune it the same as a stale `TODO`. `## BLOCKED` is not a
     graveyard -- CLEAN is the phase that keeps it honest.
   - **Structural repair (RFC § 1.2)**: any ticket ID appearing more than
     once -- duplicated verbatim within one section, or listed under two
     different headings at once (e.g. both `[x]` under `## DONE` and `[ ]`
     under `## BLOCKED`) -- is corruption from a status change that copied
     instead of moved. Cross-check `LOG.md` for that ticket's true final
     state and keep exactly one line, under the one correct heading;
     delete the rest. Also merge duplicate section headings (e.g. two
     `## DONE` blocks) into one.

2. **Orphan Hunt:**
   - Identify and delete clearly unconnected files (orphaned assets, unused scripts).
   - Ambiguous items MUST be ticketed for human review instead of deleted.

3. **Link & Path Audit:**
   - Fix broken internal paths or dead links in markdown documentation.
   - Fix incorrect imports or references in code.

4. **Trash Removal:**
   - Delete temporary files, caches, and scaffold leftovers (e.g., `__pycache__`, `.tmp`, outdated `.bak` files).
   - Clear out empty directories.
   - **DO NOT** delete files in `.saipen/kitchen/` unless they are stale or the project is fully completed. Stale, concretely: the file's owning ticket is `DONE` and no longer on `BOARD.md` (its reasoning already folded into `LOG.md`/`CHANGELOG.md`), or its content is fully superseded by what those now record. `phases/hunt.md` checks this same definition every autonomous pass, not just when a user explicitly runs `saipen clean` -- kitchen/ MUST NOT wait indefinitely for a manual trigger to stop growing.

5. **Freshness Check:**
   - Ensure the repository is up to date with correct paths.
   - Confirm project dependencies are clean and aligned.

After cleanup is complete, LOG one normal Event Graph line per RFC § 1.2 --
`- DATE [E-###] [parent: E-###] RUN: clean -> done @SHORT-HASH` -- never an
ad-hoc marker like `[E-CLEAN]`. `E-###` continues the same numbered
sequence as every other entry; CLEAN gets no special ID format. Transition
phase back to `DONE`.
