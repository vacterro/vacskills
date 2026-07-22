# Phase: DONE

There is no more work to do on the current ticket.

1. **Pending Tickets FIRST**: If there are `TODO` tickets remaining on `BOARD.md`, the agent MUST transition to `SCOUT` to begin the next workable ticket (or `PLAN` if the board explicitly calls for a new wave to be planned). Do not stop. If all remaining `TODO` tickets are unworkable (e.g. blocked by unmet `needs:` that aren't in `DONE`), transition to `BLOCKED`.
2. **Goal Mode Empty Board**: If the board is empty, check `goal_mode` in `STATE.md`. `goal_mode: true` means you arrived here on your own mid-run. Per RFC § 2.4, an empty board is a waypoint, never a stop: proceed immediately to `HUNT`. Do NOT write `next_action: wait for user command` while `goal_mode: true` -- that value is only ever correct when `goal_mode: false`.
3. **Manual Empty Board**: If the board is empty, `goal_mode: false`, and the user simply typed `saipen` (or `/saipen`), that bare command already auto-transitions to `HUNT` per RFC § 2.1 -- just proceed, there is no separate command to invoke.
4. **New Goals**: If the user wants to start a new project or big feature, run `saipen goal <text>` (sets phase to PLAN).
5. **Bugs**: If there are unresolved bugs, run `saipen SYMPTOM` (bare invocation -- there is no separate `fix` subcommand).
6. **Brainstorming**: If the user asks to add new features or brainstorm, that's free text for `saipen goal <text>` or a normal ticket via PLAN -- there is no separate `add` command; `ADD` itself is only ever reached autonomously via a clean `HUNT` (RFC § 2.1).
