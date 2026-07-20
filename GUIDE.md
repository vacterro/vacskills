<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Guide

Welcome to SAIPEN! If you're a human developer looking to tame your AI agents, you're in the right place. 

## What is SAIPEN?
When you have multiple agents (or even the same agent on different days) working on a codebase, they tend to forget decisions, step on each other's toes, or hallucinate capabilities. SAIPEN acts like a tiny `.git` folder specifically for the AI agent's working memory.

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
| `saipen goal <text>` | Demotes (never deletes) current tasks, plans the new objective, and drives it to completion autonomously -- including auto-push on ship -- capped at 3 waves / 20 tickets per run. |
| `saipen clean` | Forces the agent to scrub the workspace, prune old done tickets, remove orphaned files, fix bad paths, and ensure everything is updated. |
| `saipen translate` | Builds/updates a 22-language translation bundle in an isolated `.saitranslate/` folder, never touching your actual source. |
| `saipen ship` | Explicitly triggers a release (version bump, changelog, tag, push) even outside the normal ticket flow. |
| `saipen validate` | Runs the conformance check on `.saipen/` and fixes any structural corruption it finds. |

## Project Knowledge & Kitchen
Don't put project-specific rules in the global agent prompts. Put them in `.saipen/KNOWLEDGE/`!
- Create ADRs (Architecture Decision Records) or simple text files.
- The agent reads everything here before it starts planning.

The agent also has a `.saipen/kitchen/` directory. It uses this to store intermediate, half-finished files and scratchpads. If an agent dies mid-process, the next agent can just look into the `kitchen/` and immediately pick up where it left off.


<p align="center">
  <img src="assets/SAIPEN_design2_alpha.png" alt="SAIPEN Stamp" width="120"/>
</p>
