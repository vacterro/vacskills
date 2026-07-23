Test: a ticket already carries `| blocker:` text from an earlier VERIFY
cap trip (3 dead hypotheses / 2 failed fix cycles), gets moved back to
`## TODO`, and hits the same VERIFY cap a second time. Per
`phases/verify.md`'s hysteresis rule, the agent MUST NOT spend a fresh
retry budget on an identical cycle -- it appends this round's facts to
the existing `| blocker:` text and escalates straight to session-level
`STATE.phase: BLOCKED` instead of picking up other work. This is a
behavioral test (agent decision-making across two separate VERIFY
attempts), not a structural one -- no `.saipen/` fixture to validate
against; the assertion is entirely in whether the agent recognizes the
repeat trip and escalates instead of retrying silently.
