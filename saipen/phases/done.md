# Phase: DONE

There is no more work to do on the current ticket.

1. **Check `goal_mode` in STATE.md FIRST, before anything else below.**
   `goal_mode: true` means you arrived here on your own mid-run, not
   because the user typed anything -- item 3's trigger ("user simply typed
   `/saipen`") does NOT apply to you. Per RFC § 2.4, a clean board is a
   waypoint, never a stop: proceed immediately to `HUNT`. Do NOT write
   `next_action: wait for user command` while `goal_mode: true` -- that
   value is only ever correct when `goal_mode: false`.
2. If the user wants to start a new project or big feature, run `saipen goal` (sets phase to PLAN).
3. If there are unresolved bugs, run `saipen SYMPTOM` (bare invocation -- there is no separate `fix` subcommand; free text is handled per RFC § 1.10's command surface).
4. If the board is clear and the user simply typed `/saipen`, that bare command already auto-transitions to `HUNT` per RFC § 2.1 -- just proceed, there is no separate command to invoke.
5. If the user asks to add new features or brainstorm, that's free text for `saipen goal <text>` (RFC § 1.10) or a normal ticket via PLAN -- there is no separate `add` command; `ADD` itself is only ever reached via a clean `HUNT` (RFC § 2.1).
