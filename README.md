# vacskill — One Skill. Any Agent. Zero Amnesia.

**v3.1.2** · [Changelog](CHANGELOG.md) · plain markdown · zero dependencies · MIT

Your AI agent died mid-work. Again. And the next one greets you with
"So, tell me about your project!" like some intern on day one. To hell
with that. Open ANY other agent, say `VACSKILL SET` — it reads the
project's notebook and continues from the EXACT ticket the corpse dropped.
No re-explaining. Not once. Not ever.

## The whole idea, no PhD required

Models come and go — Claude today, GPT tomorrow, some local Llama on a
toaster next year. The **notebook stays**. Memory owns the project; the
model is just a temporary worker with a shovel.

```
vacskill/                   ← this repo, clone anywhere
  vacskill/SKILL.md         cold protocol — how robots work, no feelings
  vacskill/STYLE.md         the voices — kept OUT of the protocol's way
  vacskill/UI.md            the look (Win95 dark gold) — loaded only for UI
  inject.ps1 / inject.sh    one-shot installer

your-project/.vacskill/     ← the notebook, robots build it themselves
  STATE.md                  where we are + the EXACT next command
  BOARD.md                  tickets with needs: dependencies — the boss
  LOG.md                    diary: every run, every decision, one line each
  KNOWLEDGE/                what's TRUE: architecture, conventions,
                            decisions, traps — outlives every damn model
```

Diary says what HAPPENED. Knowledge says what's TRUE. Mixing those two is
how projects end up with a 1800-line log nobody reads — we don't do that
here.

## Install — three commands, no crying

```
git clone https://github.com/vacterro/vacskill
cd vacskill
powershell -ExecutionPolicy Bypass -File .\inject.ps1     # Windows
bash inject.sh                                            # macOS / Linux
```

The injector sniffs out every agent on your machine — Claude Code,
OpenCode, Codex, Gemini/Antigravity, Aider, generic `~/.agents` readers —
and wires vacskill into each as default. Re-run after every `git pull`; it
skips what's done and refreshes what's stale. Idiot-proof, tested on
actual idiots (us).

## How to use it

Every command takes `vacskill` or the short alias `vac`. Same thing, pick
your poison.

| You say | What happens |
|---|---|
| `vacskill build me X` | notebook born, tickets planned, work starts |
| `vacskill` / `VACSKILL SET` | continues from notebook; empty board → hunts bugs itself |
| `vacskill fix <thing>` | reproduce → root cause → regression test. No guessing |
| `vacskill status` | reads notebook + quick numbers, touches nothing |
| `vacskill stop` | proper goodbye note, safe to walk away |
| `vacskill ship` | inspection → 100% green → YOUR GitHub, versioned + changelog |

**Every ticket walks the same road:** SCOUT (read how the repo already
does it — inventing a parallel architecture is how agents ruin projects) →
BUILD (smallest safe change, no stubs, no "TODO later" lies) → VERIFY
(run it for real; ticket closes with honest confidence: high/med/low).
REVIEW guards the whole diff before ship: correctness → security →
reliability. Red never ships. **Never.**

**The board is the boss.** Tickets carry `needs:` dependencies; the robot
takes the top unblocked ticket, period. "I felt like polishing the README
first" — no. T-001. Dig. Several agents at once? Each claims a `[P]`
ticket, DAG keeps them out of each other's pants, a join ticket re-checks
the merge.

**Death is budgeted.** Checkpoints after EVERY ticket — a dying agent gets
no goodbye speech, so nothing waits for one. Worst crash loses one ticket,
and `git status` shows even that. Next robot picks it up cold.

**It cleans up after itself.** Scratch junk lives in `.vacskill/tmp/`,
deleted at stop. Orphan files get deleted only when PROVEN unreferenced —
or you said so. No `.env` ever reaches GitHub; guards check before every
commit.

**Voices know their place** ([vacskill/STYLE.md](vacskill/STYLE.md)): chat
is short and dry; the LOG diary is written by a furious wise grandpa with
human dates (`15.07.26 14:32`, not ISO soup) and one closing haiku per
session — because "fixed the damn timeout AGAIN" is remembered a month
later and "Fixed issue." is forgotten by lunch. Code, commits, docs:
boring on purpose. Facts exact in every voice.

**Any UI comes out Win95 dark golden** ([vacskill/UI.md](vacskill/UI.md)):
Verdana, zero antialiasing, sharp bevels, zero animations. Non-negotiable.
Gorgeous.

## Why it doesn't fall apart

- Every loop has a hard cap: 3 dead hypotheses or 2 failed fixes →
  ticket BLOCKED with facts, next ticket. No robot spinning in circles
  burning your money at 3am.
- Publish is opt-in only — your projects never land on GitHub uninvited.
- Two agents, one project → takeover guard asks before grabbing the wheel.
- Versions grow slow and honest: `3.1.0 → 3.1.0a` micro, `3.2.1` little,
  `3.2.0` feature. No jumping to v9 because the README got a new emoji.
- Every shipped state is tagged and recoverable forever — `git show
  v1.0.0:vacskill/SKILL.md` hands you the ancient one, no archive folders
  rotting in the tree. Your project memory rides the same rails: it's
  committed, so `git show <rev>:.vacskill/STATE.md` rewinds any day of work.
- The protocol polices its own waistline: capped at ~250 lines, new rule
  must evict a stale one. Bloat IS the drift it warns about.

## Upgrading from VAC (pre-3.0)

Everything got one name: the skill, the folder, the memory. Pull and re-run
the injector — it strips the old `VAC` blocks, drops the old skill dirs and
wires `vacskill` in their place. In your projects: `git mv .vac .vacskill`.
The agent will do it for you on the next `VACSKILL SET` anyway.

## House rules (for editing this system)

Protocol stays cold; personality stays in STYLE.md; theme stays in UI.md.
Add a section, not a file. If the model already knows it, don't write it.
Improvements come from real usage pain only — speculative features are fat,
not muscle.

MIT. Take it, wire it, ship your own stuff with it.
