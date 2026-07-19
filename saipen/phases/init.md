# Phase: INIT

No `.saipen/` directory found. Copy `extensions/templates/` (`STATE.md`,
`BOARD.md`, `LOG.md`) from the SAIPEN home -- do NOT freehand the schema.
Templates missing or unreachable (degraded capability only)? Write by hand,
matching exactly:
- `STATE.md`: frontmatter `phase: PLAN`, `task: none`, `next_action: "Ask
  the user for the first goal, then PLAN tickets onto BOARD.md"`,
  `blocker: none`, `agent: none`, `saipen_version: 7`, `schema_version: 1`,
  `goal_mode: false`, `updated:` (ISO now).
- `BOARD.md`: `## DOING` / `## TODO` / `## DONE`, no tickets yet.
- `LOG.md`: starts empty. The first REAL entry (once work begins) MUST
  already follow the § 1.2 LOG skeleton -- no placeholder/example line
  gets written into a fresh project.
- `KNOWLEDGE/` directory (created on first need, not upfront).

After bootstrap is physically written to disk, transition:
STATE -> `PLAN`
