# Phase: PLAN

Amplify user intent into tickets. <=8 lines of analysis: edge cases,
callers, migrations, UI states. Safe defaults over interrogation.

Ticket shape: one goal, independently verifiable, `needs:` for deps.
Board order = execution order. >10 tickets: waves, detail current only.

**Size gate:** <=2 files + obvious change: skip PLAN, edit, verify, LOG, done.

After PLAN: STATE -> SCOUT for first ticket.
If `goal_mode: true` (RFC § 2.4): do not pause here -- proceed straight into SCOUT.