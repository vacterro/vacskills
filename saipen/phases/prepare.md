# Phase: PREPARE

Entered by explicit user command: `saipen prepare`.

This phase is primarily used by specialized roles and subSaipens (e.g., `saitranslate`, `saiwiki`, `saihunt`) to finalize their work and package it for the next agent (usually the main project agent) to consume.

1. **Freshness Check**: Before preparing the result, verify that your findings or outputs are still valid against the *current* project HEAD. If the main project has moved and invalidated your work, update your work first. The payload MUST be fresh.
2. **Core Result Formatting**: Assemble your final artifacts (code, translations, documentation, or hunt reports). Ensure they are complete and structurally sound.
3. **Comprehensive Instructions**: Write a clear, step-by-step guide for the *next agent* explaining exactly how to inject or use this core result in the main software. Assume the next agent has zero context about your internal process.
4. **Delivery**: 
   - If you are running as a subSaipen (RFC § 1.9), write the combined result and instructions into your `kitchen/OUTBOX.md` with `status: ready`, and mark your current ticket as `[x]` in `## DONE`.
   - If you are running in the main project, place the packaged payload in `kitchen/` or the designated target path.
5. **Completion**: LOG one Event Graph line per RFC § 1.2 -- `- DATE
   [E-###] [parent: E-###] RUN: prepare -> done` -- then `STATE.phase ->
   DONE`. Preparation failed (freshness check found the work stale beyond
   repair, or delivery target unwritable)? LOG `RUN: prepare -> FAILED
   <reason>` (this exact text after the taxonomy) instead, then
   `STATE.phase -> BLOCKED` with the facts.
