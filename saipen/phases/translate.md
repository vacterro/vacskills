# Phase: TRANSLATE (triggered by `saipen translate`)

Deep, isolated translation preparation system. This phase runs in a strictly quarantined environment and focuses exclusively on building a massive translation bundle without touching the main software.

1. **Isolation Rule:**
   - "Exclusively inside `.saitranslate/`" scopes the *translation work itself* -- the software's source and assets. It does NOT suspend normal SAIPEN bookkeeping: `.saipen/STATE.md`/`BOARD.md`/`LOG.md` still get checkpointed exactly as every other phase requires (§ 1.5). Isolation and protocol discipline are not in tension.
   - You MUST NOT touch, modify, or inject code into the main project files during this phase. Treat the main project strictly as a read-only reference to understand what strings need translation.
   - `.saitranslate/` has its own `kitchen/` for scratch and half-finished work -- separate from `.saipen/kitchen/`, never shared with it. Nothing from this phase's scratch work belongs in the main project's kitchen.

2. **Core Translation Build:**
   - Establish a robust translation system infrastructure (e.g., JSON bundles, structured locales) inside `.saitranslate/`.
   - You MUST translate the software strings into the following 22 languages, **prioritizing: English, Russian, Estonian, and Japanese**.
   - The full list is: *English, Russian, Estonian, Japanese, Ukrainian, German, French, Spanish, Italian, Portuguese, Dutch, Polish, Swedish, Danish, Finnish, Norwegian, Chinese, Korean, Thai, Vietnamese, Arabic, Hebrew*.
   - **UI Assets:** For each language, associate a flag icon and the config
     for live-switching in Settings. Unicode regional-indicator flag emoji
     (🇺🇸🇷🇺🇪🇪🇯🇵...) are the universal baseline every agent can produce
     without an image tool; use drawn/SVG assets only if the platform
     supports image generation and the project's existing icons are already
     that style -- match the project, don't invent a new asset pipeline.
   - **Bonus Voice:** You MUST also build a `«Дед»` (angry-grandpa) voice localization.

3. **Maintenance and Update:**
   - If the core translation system already exists, compare it against the latest main software strings.
   - Update missing translations across all 22 languages and the bonus voice to ensure 100% coverage.

4. **Completion:**
   - Once the translation bundle is fully built, validated, and up-to-date,
     LOG exactly `RUN: translate -> done @SHORT-HASH` (this exact format,
     not a free-text summary), then transition the phase back to `DONE`.
   - The bundle sits safely in `.saitranslate/kitchen/` until a future `ADD`
     phase formally integrates it into the software.
