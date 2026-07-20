#!/bin/bash
# saipen conformance validator

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}saipen conformance validation starting...${NC}"

# 1. Check STATE.md
if [ ! -f ".saipen/STATE.md" ]; then
    echo -e "${RED}FAIL: STATE.md missing${NC}"
    exit 1
fi
grep -qE "phase:[[:space:]]+(INIT|PLAN|SCOUT|BUILD|VERIFY|REVIEW|SHIP|DONE|BLOCKED|VALIDATE|HUNT|ADD|CLEAN|TRANSLATE)" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing valid phase${NC}"; exit 1; }
grep -q "task:" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing task${NC}"; exit 1; }
grep -q "next_action:" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing next_action${NC}"; exit 1; }
grep -q "blocker:" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing blocker${NC}"; exit 1; }
grep -q "agent:" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing agent${NC}"; exit 1; }
grep -q "updated:" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing updated${NC}"; exit 1; }
grep -qE "mode:[[:space:]]+(full|read-only|no-publish|manual-verify)" .saipen/STATE.md || { echo -e "${RED}FAIL: STATE.md missing mode, or mode isn't one of full|read-only|no-publish|manual-verify${NC}"; exit 1; }
echo -e "${GREEN}PASS: STATE.md schema valid${NC}"

# 1b2. mode/phase basic compatibility (RFC § 1.3) -- not the full matrix,
# just the two restrictions already stated normatively in prose.
if grep -qE "mode:[[:space:]]+no-publish" .saipen/STATE.md && grep -qE "phase:[[:space:]]+SHIP" .saipen/STATE.md; then
    echo -e "${RED}FAIL: mode: no-publish MUST NOT transition to SHIP (RFC § 1.3)${NC}"
    exit 1
fi
if grep -qE "mode:[[:space:]]+read-only" .saipen/STATE.md && grep -qE "phase:[[:space:]]+(BUILD|SHIP|CLEAN|TRANSLATE)" .saipen/STATE.md; then
    echo -e "${RED}FAIL: mode: read-only MUST NOT enter BUILD/SHIP/CLEAN/TRANSLATE (RFC § 1.3)${NC}"
    exit 1
fi

# 1b. goal_mode: true requires the persisted safety-valve counters (RFC § 2.4)
if grep -qE "goal_mode:[[:space:]]+true" .saipen/STATE.md; then
    grep -qE "goal_waves:[[:space:]]*[0-9]+" .saipen/STATE.md || { echo -e "${RED}FAIL: goal_mode: true but goal_waves counter missing -- safety valve can't survive a restart without it${NC}"; exit 1; }
    grep -qE "goal_tickets:[[:space:]]*[0-9]+" .saipen/STATE.md || { echo -e "${RED}FAIL: goal_mode: true but goal_tickets counter missing -- safety valve can't survive a restart without it${NC}"; exit 1; }
    echo -e "${GREEN}PASS: goal_mode counters present${NC}"
fi

# 2. Check BOARD.md (cycles are complex in pure bash, doing basic syntax check)
if [ ! -f ".saipen/BOARD.md" ]; then
    echo -e "${RED}FAIL: BOARD.md missing${NC}"
    exit 1
fi
echo -e "${GREEN}PASS: BOARD.md exists (acyclic check requires powershell/python wrapper currently)${NC}"

# 2b. Check BOARD.md for duplicate ticket IDs -- a status change that
# copied a ticket line instead of moving it (RFC § 1.2) leaves the same
# T-### appearing twice, either within one section or across two.
DUPE_IDS=$(grep -oE '\- \[[ x/]\] T-[0-9]+' .saipen/BOARD.md | grep -oE 'T-[0-9]+' | sort | uniq -d || true)
if [ -n "$DUPE_IDS" ]; then
    echo -e "${RED}FAIL: BOARD.md has duplicate ticket ID(s): $(echo "$DUPE_IDS" | tr '\n' ' ') -- a status change must move the line (cut+paste), never copy it${NC}"
    exit 1
fi
echo -e "${GREEN}PASS: BOARD.md no duplicate tickets${NC}"

# 2c. Check BOARD.md for dangling needs: references -- worse than a cycle:
# a needs: pointing at a T-### that doesn't exist anywhere on the board
# leaves the Pick Rule permanently unsatisfiable with zero diagnostic signal.
ALL_IDS=$(grep -oE '\- \[[ x/]\] T-[0-9]+' .saipen/BOARD.md | grep -oE 'T-[0-9]+' | sort -u)
NEEDS_REFS=$(grep -oE 'needs:[^|]*' .saipen/BOARD.md | sed 's/needs://' | tr ',' '\n' | grep -oE 'T-[0-9]+' | sort -u)
DANGLING=""
for ref in $NEEDS_REFS; do
    echo "$ALL_IDS" | grep -qx "$ref" || DANGLING="$DANGLING $ref"
done
if [ -n "$DANGLING" ]; then
    echo -e "${RED}FAIL: BOARD.md has dangling needs: reference(s):$DANGLING -- referenced ticket doesn't exist anywhere on the board${NC}"
    exit 1
fi
echo -e "${GREEN}PASS: BOARD.md no dangling needs: references${NC}"

# 2d. Check BOARD.md has all four required section headings (RFC § 1.2) --
# the ticket-shape/dangling/cycle checks above never verified the headings
# they scan under actually exist.
for heading in "## DOING" "## TODO" "## DONE" "## BLOCKED"; do
    grep -qxF "$heading" .saipen/BOARD.md || { echo -e "${RED}FAIL: BOARD.md missing required section heading: $heading${NC}"; exit 1; }
done
echo -e "${GREEN}PASS: BOARD.md has all required section headings${NC}"

# 3. Check LOG.md -- every non-empty, non-comment line MUST match (date
# prefix is optional to allow pre-STYLE.md history; new entries carry one).
if [ -f ".saipen/LOG.md" ]; then
    LOG_PATTERN="^-[[:space:]]+([0-9]{2}[.\/][0-9]{2}[.\/][0-9]{2}[[:space:]]+[0-9]{2}:[0-9]{2}[[:space:]]+)?\[E-[0-9]+\]([[:space:]]+\[parent:[[:space:]]+E-[0-9]+\])?"
    BAD_LINES=$(grep -vE "^#" .saipen/LOG.md | grep -vE "^$" | grep -vE "$LOG_PATTERN" || true)
    if [ -n "$BAD_LINES" ]; then
        echo -e "${RED}FAIL: LOG.md entry violates Graph Event format:${NC}"
        echo "$BAD_LINES"
        exit 1
    fi
    echo -e "${GREEN}PASS: LOG.md format valid${NC}"
fi

# 4. Check KNOWLEDGE/
if [ -d ".saipen/KNOWLEDGE" ]; then
    if grep -rE "^-[[:space:]]+[0-9]{2,4}[-/.][0-9]{2}[-/.][0-9]{2}.*(RUN|DEC|H):" .saipen/KNOWLEDGE/ >/dev/null 2>&1; then
        echo -e "${RED}FAIL: KNOWLEDGE/ leak: found event journal syntax${NC}"
        exit 1
    fi
    echo -e "${GREEN}PASS: KNOWLEDGE/ clean${NC}"
fi

echo -e "${GREEN}Validation complete. Agent is conformant.${NC}"
