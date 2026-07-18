#!/usr/bin/env bash
# saipen injector (macOS/Linux) Р В Р’В Р В РІР‚В Р В Р’В Р Р†Р вЂљРЎв„ўР В Р вЂ Р В РІР‚С™Р РЋРЎС™ installs saipen as default on every agentic system found.
# Run from clone dir:  bash inject.sh
# Idempotent: re-run safe. Also migrates pre-3.0 installs named "VAC".

set -u
SKILL_HOME="$(cd "$(dirname "$0")/../saipen" 2>/dev/null && pwd)"
[ -f "$SKILL_HOME/RFC.md" ] || { echo "FATAL: saipen/RFC.md not found"; exit 1; }

backup_file() {
  [ -f "$1" ] && [ ! -f "$1.bak" ] && cp "$1" "$1.bak"
}

BLOCK="
<!-- SAIPEN:BEGIN -->
## saipen protocol (global)
On \"saipen SET\" / \"saipen ...\" (short alias \"vac ...\") commands, or when
project root contains .saipen/: read $SKILL_HOME/RFC.md + $SKILL_HOME/STYLE.md
and follow them.
Memory: .saipen/ at project root - read .saipen/STATE.md before work;
checkpoint BOARD + STATE after every ticket, LOG line after every run.
Path missing (new machine)? clone github.com/vacterro/saipen.
UI work: also obey $SKILL_HOME/UI.md (Win95 dark golden, Verdana, no AA).
<!-- SAIPEN:END -->"

# Pre-3.0 block points at the old VAC/ folder Р В Р’В Р В РІР‚В Р В Р’В Р Р†Р вЂљРЎв„ўР В Р вЂ Р В РІР‚С™Р РЋРЎС™ strip it before adding the new one.
strip_legacy_block()  # Strip old SAIPEN, ASP, and VACSKILL blocks
{
  backup_file "$1"
  sed -i.bak '/<!-- SAIPEN:BEGIN -->/,/<!-- SAIPEN:END -->/d' "$1" 2>/dev/null || sed -i '' '/<!-- SAIPEN:BEGIN -->/,/<!-- SAIPEN:END -->/d' "$1"
  sed -i.bak '/<!-- ASP:BEGIN -->/,/<!-- ASP:END -->/d' "$1" 2>/dev/null || sed -i '' '/<!-- ASP:BEGIN -->/,/<!-- ASP:END -->/d' "$1"
  sed -i.bak '/<!-- VACSKILL:BEGIN -->/,/<!-- VACSKILL:END -->/d' "$1" 2>/dev/null || sed -i '' '/<!-- VACSKILL:BEGIN -->/,/<!-- VACSKILL:END -->/d' "$1"
  return 0
}

add_block() { # $1=file
  local migrated=1
  strip_legacy_block "$1" && migrated=0
  if [ -f "$1" ] && grep -q "SAIPEN:BEGIN" "$1"; then
    if grep -q "PROTOCOL\.md" "$1"; then echo "already"; return; fi
    # 3.x block points at SKILL.md Р В Р’В Р В РІР‚В Р В Р’В Р Р†Р вЂљРЎв„ўР В Р вЂ Р В РІР‚С™Р РЋРЎС™ replace with RFC.md block
    backup_file "$1"
    sed -i.bak '/<!-- SAIPEN:BEGIN -->/,/<!-- SAIPEN:END -->/d' "$1" 2>/dev/null || sed -i '' '/<!-- SAIPEN:BEGIN -->/,/<!-- SAIPEN:END -->/d' "$1"
    printf '%s\n' "$BLOCK" >> "$1"; echo "block upgraded to RFC.md"; return
  fi
  backup_file "$1"
  mkdir -p "$(dirname "$1")"; printf '%s\n' "$BLOCK" >> "$1"
  [ $migrated -eq 0 ] && echo "migrated from VAC" || echo "block added"
}

# Remove a pre-3.0 skill dir: symlinks always, real dirs only if ours.
rm_legacy() { # $1=path
  [ -e "$1" ] || return 1
  if [ -L "$1" ]; then rm "$1"; return 0; fi
  if [ -f "$1/SKILL.md" ] && grep -qE '^name: *(VAC|vacskill) *$' "$1/SKILL.md"; then
    rm -rf "$1"; return 0
  fi
  return 1
}

copy_skill() { # $1=dst $2=legacy
  [ -n "${2:-}" ] && rm_legacy "$2"
  mkdir -p "$1"
  cp "$SKILL_HOME/SKILL.md" "$SKILL_HOME/RFC.md" "$SKILL_HOME/UI.md" "$SKILL_HOME/STYLE.md" "$1/"
  echo "copied (re-run after updates)"
}

echo "saipen injector (source: $SKILL_HOME)"
echo "------------------------------------------------------------"
[ -d "$HOME/.claude" ]          && { printf '%-28s %s\n' "Claude Code skill"     "$(copy_skill "$HOME/.claude/skills/saipen" "$HOME/.claude/skills/VAC")";
                                     printf '%-28s %s\n' "Claude Code CLAUDE.md" "$(add_block "$HOME/.claude/CLAUDE.md")"; } \
                                || printf '%-28s %s\n' "Claude Code" "not installed - skip"
[ -d "$HOME/.config/opencode" ] && { printf '%-28s %s\n' "OpenCode skill"        "$(copy_skill "$HOME/.config/opencode/skills/saipen" "$HOME/.config/opencode/skills/vac")";
                                     printf '%-28s %s\n' "OpenCode AGENTS.md"    "$(add_block "$HOME/.config/opencode/AGENTS.md")"; } \
                                || printf '%-28s %s\n' "OpenCode" "not installed - skip"
[ -d "$HOME/.codex" ]           && { printf '%-28s %s\n' "Codex skill"           "$(copy_skill "$HOME/.codex/skills/saipen" "$HOME/.codex/skills/vac")";
                                     printf '%-28s %s\n' "Codex AGENTS.md"       "$(add_block "$HOME/.codex/AGENTS.md")"; } \
                                || printf '%-28s %s\n' "Codex" "not installed - skip"
[ -d "$HOME/.gemini" ]          && printf '%-28s %s\n' "Gemini GEMINI.md"        "$(add_block "$HOME/.gemini/GEMINI.md")" \
                                || printf '%-28s %s\n' "Gemini" "not installed - skip"

if [ -d "$HOME/.agents/skills" ]; then # copy, lowercase: these readers skip links/uppercase
  rm_legacy "$HOME/.agents/skills/VAC"
  printf '%-28s %s\n' "~/.agents skills" "$(copy_skill "$HOME/.agents/skills/saipen" "$HOME/.agents/skills/vac")"
else printf '%-28s %s\n' "~/.agents" "not installed - skip"; fi

if command -v aider >/dev/null 2>&1; then
  A="$HOME/.aider.conf.yml"
  P="$SKILL_HOME/RFC.md"
  if [ ! -f "$A" ]; then printf '# saipen protocol auto-loaded\nread:\n  - %s\n' "$P" > "$A"; printf '%-28s %s\n' "Aider conf" "created"
  elif grep -qE '/(VAC|vacskill)/SKILL\.md' "$A"; then
    backup_file "$A"
    sed -i.bak "s#.*/\(VAC\|saipen\)/SKILL\.md#  - $P#" "$A" 2>/dev/null || sed -i '' "s#.*/\(VAC\|saipen\)/SKILL\.md#  - $P#" "$A"
    printf '%-28s %s\n' "Aider conf" "migrated to RFC.md"
  elif grep -qF "$P" "$A"; then printf '%-28s %s\n' "Aider conf" "already"
  elif ! grep -q "^read:" "$A"; then 
    backup_file "$A"
    printf '\n# saipen protocol auto-loaded\nread:\n  - %s\n' "$P" >> "$A"; printf '%-28s %s\n' "Aider conf" "read: appended"
  else printf '%-28s %s\n' "Aider conf" "has own read: - add manually: $P"; fi
else printf '%-28s %s\n' "Aider" "not installed - skip"; fi

echo "------------------------------------------------------------"
echo "Done. Test: open any project in any agent, say: saipen SET"
