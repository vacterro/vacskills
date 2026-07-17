---
name: asp
description: >
  Agent Session Protocol (v7). Trigger on "asp SET", "asp",
  and subcommands. 2-tier architecture: boot RFC.md
  loads always; phases/ modules load on demand per STATE.
  Persistent .asp/ memory lets any agent continue another's work.
---

# asp -- skill adapter

Thin entry for skill-reading platforms. The system lives elsewhere:

1. **Read `RFC.md` here -- the boot protocol. Follow it.**
2. **Read `STYLE.md` here -- voices. Load both.**
3. **Phase modules in `phases/` -- loaded by boot per STATE.md phase.**
4. UI work: also read `UI.md` (Win95 dark golden, Verdana, no AA).

Platform notes:
- Native task lists mirror `.asp/BOARD.md`, never replace it.
- Prefer file tools over shell redirects -- UTF-8 no BOM.
- RFC.md decides. No rule here overrides it.