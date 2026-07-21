<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Guide

Welcome to SAIPEN! If you're a human developer looking to tame your AI agents, you're in the right place. 

## What is SAIPEN?
When you switch agents (or use the same agent on different days) working on a codebase, they tend to forget decisions, step on each other's toes, or hallucinate capabilities. SAIPEN acts like a tiny `.git` folder specifically for the AI agent's working memory.

## How it works
1. **Global Install:** You run `bootstrap/inject.ps1` (or `.sh`) once on your machine. This teaches Claude, Gemini, Aider, and Antigravity what SAIPEN is.
2. **Project Init:** You open an agent in your project folder and type `saipen set` (or `saipen init`). The agent reads its global rules and creates a `.saipen/` directory in your current project.
3. **Working Memory:** From now on, the agent stores its current task, progress board, and logs in `.saipen/STATE.md` and `.saipen/BOARD.md`.
4. **Resuming:** You close your laptop, wait a week, open a completely different agent, and type `/saipen continue`. The new agent reads the `.saipen/` folder and resumes exactly where the old one left off.

## Commands you can type to the Agent
While agents interact with the file system directly, you just type normal chat messages to control them:

| What you type | What the agent does |
|---|---|
| `saipen set` | Bootstraps the project with `.saipen/` memory and starts planning. |
| `saipen continue` | Wakes up, reads the state, and executes the very next action. |
| `saipen stop` | Forces the agent to checkpoint its work and hand control back to you. |
| `saipen status` | Reads `.saipen/BOARD.md` and tells you what's currently going on without doing work. |
| `saipen goal <text>` | Demotes (never deletes) current tasks, plans the new objective, and drives it forward autonomously -- including auto-push on ship. Shipping the objective isn't the stopping point either: it falls straight into autonomous HUNT/ADD maintenance until the product is mature, blocked, or the run hits its cap (3 waves / 20 tickets). |
| `saipen clean` | Forces the agent to scrub the workspace, prune old done tickets, remove orphaned files, fix bad paths, and ensure everything is updated. |
| `saipen translate` | Builds/updates a 32-language translation bundle in an isolated `.saitranslate/` folder, never touching your actual source. |
| `saipen ship` | Explicitly triggers a release (version bump, changelog, tag, push) even outside the normal ticket flow. |
| `saipen validate` | Runs the conformance check on `.saipen/` and fixes any structural corruption it finds. |

## Multilingual Guides / Руководства на разных языках

Read SAIPEN guides in your native language:

| | | |
|---|---|---|
| 🇷🇺 [Русский](GUIDE_RU.md) | 🇺🇸 [English](GUIDE_EN.md) | 🇪🇪 [Eesti](GUIDE_EE.md) |
| 🇯🇵 [日本語](GUIDE_JA.md) | 👴 [Версия Деда](GUIDE_DED.md) | 🇺🇦 [Українська](GUIDE_UK.md) |
| 🇩🇪 [Deutsch](GUIDE_DE.md) | 🇫🇷 [Français](GUIDE_FR.md) | 🇪🇸 [Español](GUIDE_ES.md) |
| 🇮🇹 [Italiano](GUIDE_IT.md) | 🇵🇹 [Português](GUIDE_PT.md) | 🇳🇱 [Nederlands](GUIDE_NL.md) |
| 🇵🇱 [Polski](GUIDE_PL.md) | 🇸🇪 [Svenska](GUIDE_SV.md) | 🇩🇰 [Dansk](GUIDE_DA.md) |
| 🇫🇮 [Suomi](GUIDE_FI.md) | 🇳🇴 [Norsk](GUIDE_NO.md) | 🇨🇳 [中文](GUIDE_ZH.md) |
| 🇰🇷 [한국어](GUIDE_KO.md) | 🇹🇭 [ไทย](GUIDE_TH.md) | 🇻🇳 [Tiếng Việt](GUIDE_VI.md) |
| 🇸🇦 [العربية](GUIDE_AR.md) | 🇮🇱 [עברית](GUIDE_HE.md) | 🇹🇷 [Türkçe](GUIDE_TR.md) |
| 🇮🇳 [हिन्दी](GUIDE_HI.md) | 🇮🇩 [Bahasa Indonesia](GUIDE_ID.md) | 🇬🇷 [Ελληνικά](GUIDE_EL.md) |
| 🇨🇿 [Čeština](GUIDE_CS.md) | 🇷🇴 [Română](GUIDE_RO.md) | 🇭🇺 [Magyar](GUIDE_HU.md) |
| 🇧🇬 [Български](GUIDE_BG.md) | 🇸🇰 [Slovenčina](GUIDE_SK.md) | 🇭🇷 [Hrvatski](GUIDE_HR.md) |

## Project Knowledge & Kitchen
Don't put project-specific rules in the global agent prompts. Put them in `.saipen/KNOWLEDGE/`!
- Create ADRs (Architecture Decision Records) or simple text files.
- The agent reads everything here before it starts planning.

The agent also has a `.saipen/kitchen/` directory. It uses this to store intermediate, half-finished files and scratchpads. If an agent dies mid-process, the next agent can just look into the `kitchen/` and immediately pick up where it left off.


<p align="center">
  <img src="assets/SAIPEN_design2_alpha.png" alt="SAIPEN Stamp" width="120"/>
</p>
