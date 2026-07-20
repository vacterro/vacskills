# Phase: SHIP

## SHIP -> PUBLISH

Only on `saipen ship`, or repo has `origin` AND LOG shows prior ship, or
`goal_mode: true` (RFC § 2.4) with an existing `origin`. Never auto-publish
unopted project. Needs 100% green.

1. README beautiful: pitch, features, install, usage, version + changelog link.
2. Version bump (micro -> 3.2.1, feature -> 3.2.0, breaking -> major).
3. .gitignore covers junk + secrets. Empty tmp/, strip debug prints.
4. CHANGELOG.md newest-top. Push.
5. `git tag -a vVERSION -m "line"` + push tags.
6. First publish (no `origin` yet): confirm name + public/private with user
   -- ALWAYS, even under `goal_mode`. New public artifact is a one-way door.
7. LOG: `RUN: ship vX.Y.Z -> pushed HASH`.
8. Push rejected or fails (auth, network, non-fast-forward, hook failure):
   LOG `RUN: ship vX.Y.Z -> push FAILED <reason>` -- never claim success on
   a failed push. Commit/tag stay local. Transient (network/auth)? Retry
   once. Still failing, or non-transient (diverged history, rejected)?
   `STATE.phase: BLOCKED` -- pushing is the one SHIP step an agent must not
   guess its way through.

After SHIP: STATE -> DONE. `goal_mode: true`? Do not treat this as a
stopping point even momentarily -- `next_action` MUST already name the
next step, never a wait. `phases/done.md` § 1 sends you straight to HUNT;
board-empty is a waypoint, not an exit (RFC § 2.4).