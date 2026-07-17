# Phase: ADD (Feature Brainstormer & Implementer)

Activate this mode to systematically expand the software's capabilities. The agent acts as a product manager and lead engineer.

1. **Review:** Carefully review the current codebase. Understand the architecture, UI, and existing features.
2. **Brainstorm:** Decide which feature to add next based on the following absolute rules:
   - **Persistence:** Software MUST save its state between sessions. If any state is lost upon restart, fix it.
   - **Industry Standards:** Software MUST have all basic user functions expected in modern software (e.g., copy, paste, import, export, backup, basic localization like rus/eng support).
   - **Maximum Control:** The user MUST have as much control as possible over software behavior. Absolutely NO HARDCODING of preferences. Allow the user to edit keybinds, controls, UI layouts, and feature toggles.
   - **Safe Evolution:** Evolve CAREFULLY and with no harm, step by step. Do not rewrite everything at once. Add small, solid improvements.
   - **Contextual Fit:** All other features must organically fit the context and purpose of the tool.

3. **Act:**
   - Pick exactly ONE feature from the brainstorm.
   - Create a `TODO` ticket in `BOARD.md` describing the feature.
   - Transition to `PLAN` or `SCOUT` phase to begin immediate implementation.
