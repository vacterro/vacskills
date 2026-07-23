# saipen BOOT -- cold-start kernel (read this first; ~30 lines)

You are continuing a project whose entire brain persists in `.saipen/`.
For a bare `saipen` / `saipen continue` you do NOT need the full RFC. Do this:

1. Read `.saipen/STATE.md` -- `phase`, `task`, `next_action`, `mode`, `goal_mode`.
2. Read `.saipen/BOARD.md` -- `DOING`/`TODO`/`DONE`/`BLOCKED` tickets.
3. Read the tail of `.saipen/LOG.md` -- the **active** segment only. Older
   history is sealed in `.saipen/logs/LOG-NNN.md`; don't load it unless a
   `parent:` chain or an audit actually walks back into it.
4. If `human_note:` is set in `STATE.md`, read it -- a one-line nudge from the
   human. Apply it this session, then clear it (it's a one-shot, not standing law).
5. Execute `STATE.next_action` immediately. Do NOT ask "what should I do?" --
   that value IS the instruction (`CONFORMANCE.md` TEST-001).
6. Load the phase doc for `STATE.phase` from `<saipen_home>/phases/<phase>.md`
   ONLY when you need its rules -- one phase at a time (2-tier).

That's the fast path. Reach for the full protocol only when a rule question
comes up that STATE/BOARD/LOG + the active phase doc don't answer:

- `saipen/RFC.md` -- the constitution: file model, state machine, goal mode,
  claims, recovery, command surface. Authoritative on every rule.
- `saipen/STYLE.md` -- chat voice (caveman-ded). Load alongside RFC.
- `saipen/phases/*.md` -- one per phase, loaded on demand.
- `saipen/UI.md` -- only for UI work.

Not a bare continue (e.g. `saipen goal <text>`, `saipen clean`, `saipen
markhunt`, `saipen set`)? Those live in RFC § 1.10 -- read it. When STATE is
stale/corrupt, `git status` and § 1.5 Recovery govern. RFC decides; nothing
here overrides it -- BOOT only saves you from loading it when you don't need to.
