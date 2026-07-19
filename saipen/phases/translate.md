# Phase: TRANSLATE (triggered by `saipen translate`)

Deep, isolated translation preparation system. This phase runs in a strictly quarantined environment and focuses exclusively on building a massive translation bundle without touching the main software.

1. **Isolation Rule:**
   - You MUST operate EXCLUSIVELY inside a `.saitranslate/` folder at the project root.
   - You MUST NOT touch, modify, or inject code into the main project files during this phase. Treat the main project strictly as a read-only reference to understand what strings need translation.

2. **Core Translation Build:**
   - Establish a robust translation system infrastructure (e.g., JSON bundles, structured locales) inside `.saitranslate/`.
   - You MUST translate the software strings into the following 22 languages, **prioritizing: English, Russian, Estonian, and Japanese**.
   - The full list is: *English, Russian, Estonian, Japanese, Ukrainian, German, French, Spanish, Italian, Portuguese, Dutch, Polish, Swedish, Danish, Finnish, Norwegian, Chinese, Korean, Thai, Vietnamese, Arabic, Hebrew*.
   - **UI Assets:** For each language, you MUST associate or prepare a drawn flag icon and the configuration for live-switching in Settings.
   - **Bonus Voice:** You MUST also build a `«Дед»` (angry-grandpa) voice localization.

3. **Maintenance and Update:**
   - If the core translation system already exists, compare it against the latest main software strings.
   - Update missing translations across all 22 languages and the bonus voice to ensure 100% coverage.

4. **Completion:**
   - Once the translation bundle is fully built, validated, and up-to-date, `RUN: translate -> done`, log the actions, and transition the phase back to `DONE`. 
   - The bundle will sit safely in the `kitchen` until a future `ADD` phase formally integrates it into the software.
