# Phase: ADD (Evolutionary Completer)

Activate this mode to systematically expand the software's capabilities. SAIPEN is evolutionary, not creative. Its purpose is to complete software, not reinvent it.

1. **Review:** Carefully review the current codebase. Understand the architecture, UI, and existing features.
2. **Evolve:** Agent MUST NOT invent speculative, experimental, or unrelated features. Agent MUST evaluate additions strictly using the following logic:

   ```pseudocode
   FOR priority IN [
     "bugfix", 
     "complementary_feature (Bold->Italic)", 
     "workflow_step (Open->Save_As)", 
     "ux_consistency", 
     "platform_convention"
   ]:
     IF exists(priority):
       IF priority == "bugfix":
         RETURN HUNT
       IF satisfies(minimal_delta) AND satisfies(existing_design_language):
         IMPLEMENT(priority)
         RETURN VERIFY
   
   RETURN DONE
   ```

3. **Act:**
   - Pick exactly ONE obvious missing capability.
   - If the product is already mature and logically complete, **STOP**. Transition to `DONE` without hallucinating unnecessary features. Graceful completion is a successful outcome.
   - Otherwise, create a `TODO` ticket in `BOARD.md` describing the feature.
   - Transition to `PLAN` or `SCOUT` phase to begin immediate implementation.

4. **The Industrial Completion Rule:**
   - When the user requests one step of a well-known user workflow, you SHOULD evaluate what else is needed to make the feature industrially complete -- a judgment call, not mechanical (RFC § 2.3).
   - You MUST implement the *minimal coherent set* (e.g., adding "Cancel" and "Save" if asked for "Apply").
   - The smallest complete solution wins. Do not build massive epics (e.g., do not add Cloud Sync when asked for Export).
   - Complete before you extend: finish the requested workflow before proposing a different one (e.g., "Login" implies "Logout" — not OAuth or SSO). The agent SHOULD preserve user expectations before introducing new capabilities.

5. **Baseline Architectural Constraints** (apply to every `ADD`, whether or
   not the Industrial Completion Rule is in play):
   - *Session Persistence*: state the user can see or set (window position,
     size, toggles, themes) MUST save and restore between sessions.
   - *No Hardcoding*: prefer user-editable configuration (keybinds,
     controls, templates) over values baked into code.

6. Every addition MUST pass full `VERIFY` before another `HUNT` begins. Only if `HUNT` is clean may another `ADD` begin.
