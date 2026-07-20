#!/usr/bin/env pwsh
# saipen conformance validator

$ErrorActionPreference = "Stop"

function Assert-Format($Condition, $Message) {
    if (-not $Condition) {
        Write-Host "FAIL: $Message" -ForegroundColor Red
        exit 1
    }
}

Write-Host "saipen conformance validation starting..." -ForegroundColor Cyan

# 1. Check STATE.md
$stateContent = Get-Content ".saipen\STATE.md" -Raw
Assert-Format ($stateContent -match "phase:\s+(INIT|PLAN|SCOUT|BUILD|VERIFY|REVIEW|SHIP|DONE|BLOCKED|VALIDATE|HUNT|ADD|CLEAN|TRANSLATE)") "STATE.md missing valid phase"
Assert-Format ($stateContent -match "task:") "STATE.md missing task"
Assert-Format ($stateContent -match "next_action:") "STATE.md missing next_action"
Assert-Format ($stateContent -match "blocker:") "STATE.md missing blocker"
Assert-Format ($stateContent -match "agent:") "STATE.md missing agent"
Assert-Format ($stateContent -match "updated:") "STATE.md missing updated"
Assert-Format ($stateContent -match "mode:\s+(full|read-only|no-publish|manual-verify)") "STATE.md missing mode, or mode isn't one of full|read-only|no-publish|manual-verify"
Write-Host "PASS: STATE.md schema valid" -ForegroundColor Green

# 1b2. mode/phase basic compatibility (RFC § 1.3) -- not the full matrix,
# just the two restrictions already stated normatively in prose.
if ($stateContent -match "mode:\s+no-publish" -and $stateContent -match "phase:\s+SHIP") {
    Assert-Format $false "mode: no-publish MUST NOT transition to SHIP (RFC § 1.3)"
}
if ($stateContent -match "mode:\s+read-only" -and $stateContent -match "phase:\s+(BUILD|SHIP|CLEAN|TRANSLATE)") {
    Assert-Format $false "mode: read-only MUST NOT enter BUILD/SHIP/CLEAN/TRANSLATE (RFC § 1.3)"
}

# 1b. goal_mode: true requires the persisted safety-valve counters (RFC § 2.4)
if ($stateContent -match "goal_mode:\s+true") {
    Assert-Format ($stateContent -match "goal_waves:\s*\d+") "goal_mode: true but goal_waves counter missing -- safety valve can't survive a restart without it"
    Assert-Format ($stateContent -match "goal_tickets:\s*\d+") "goal_mode: true but goal_tickets counter missing -- safety valve can't survive a restart without it"
    Write-Host "PASS: goal_mode counters present" -ForegroundColor Green
}

# 2. Check BOARD.md (cycles)
$boardLines = Get-Content ".saipen\BOARD.md"
$deps = @{}
foreach ($line in $boardLines) {
    if ($line -match "- \[( |x|/)\] (T-\d+).*needs: (.*)") {
        $taskId = $matches[2]
        $needsRaw = $matches[3]
        $needsList = $needsRaw -split "," | ForEach-Object { $_.Trim() }
        $deps[$taskId] = @($needsList | Where-Object { $_ -ne "" })
    }
}

function Detect-Cycle($node, $visited, $stack) {
    $visited[$node] = $true
    $stack[$node] = $true

    if ($deps.ContainsKey($node)) {
        foreach ($neighbor in $deps[$node]) {
            if (-not $visited.ContainsKey($neighbor)) {
                if (Detect-Cycle $neighbor $visited $stack) { return $true }
            } elseif ($stack.ContainsKey($neighbor) -and $stack[$neighbor]) {
                return $true
            }
        }
    }
    $stack[$node] = $false
    return $false
}

$visited = @{}
$stack = @{}
$hasCycle = $false
foreach ($node in $deps.Keys) {
    if (-not $visited.ContainsKey($node)) {
        if (Detect-Cycle $node $visited $stack) {
            $hasCycle = $true
            break
        }
    }
}
Assert-Format (-not $hasCycle) "BOARD.md contains cyclic dependencies"
Write-Host "PASS: BOARD.md acyclic" -ForegroundColor Green

# 2b. Check BOARD.md for duplicate ticket IDs -- a status change that
# copied a ticket line instead of moving it (RFC § 1.2) leaves the same
# T-### appearing twice, either within one section or across two.
$idCounts = @{}
foreach ($line in $boardLines) {
    if ($line -match "- \[( |x|/)\] (T-\d+)") {
        $id = $matches[2]
        if ($idCounts.ContainsKey($id)) { $idCounts[$id]++ } else { $idCounts[$id] = 1 }
    }
}
$dupeIds = @($idCounts.GetEnumerator() | Where-Object { $_.Value -gt 1 } | ForEach-Object { $_.Key })
Assert-Format ($dupeIds.Count -eq 0) "BOARD.md has duplicate ticket ID(s): $($dupeIds -join ', ') -- a status change must move the line (cut+paste), never copy it"
Write-Host "PASS: BOARD.md no duplicate tickets" -ForegroundColor Green

# 2c. Check BOARD.md for dangling needs: references -- worse than a cycle:
# a needs: pointing at a T-### that doesn't exist anywhere on the board
# leaves the Pick Rule permanently unsatisfiable with zero diagnostic signal.
$allTicketIds = @{}
foreach ($id in $idCounts.Keys) { $allTicketIds[$id] = $true }
$danglingRefs = @()
foreach ($entry in $deps.GetEnumerator()) {
    foreach ($needed in $entry.Value) {
        if ($needed -ne "" -and -not $allTicketIds.ContainsKey($needed)) {
            $danglingRefs += "$($entry.Key)->$needed"
        }
    }
}
Assert-Format ($danglingRefs.Count -eq 0) "BOARD.md has dangling needs: reference(s): $($danglingRefs -join ', ') -- referenced ticket doesn't exist anywhere on the board"
Write-Host "PASS: BOARD.md no dangling needs: references" -ForegroundColor Green

# 2d. Check BOARD.md has all four required section headings (RFC § 1.2) --
# the ticket-shape/dangling/cycle checks above never verified the headings
# they scan under actually exist.
foreach ($heading in @("## DOING", "## TODO", "## DONE", "## BLOCKED")) {
    Assert-Format (($boardLines | Where-Object { $_.Trim() -eq $heading }).Count -gt 0) "BOARD.md missing required section heading: $heading"
}
Write-Host "PASS: BOARD.md has all required section headings" -ForegroundColor Green

# 3. Check LOG.md -- date prefix is optional (pre-STYLE.md history has none,
# current entries carry one), everything else is mandatory.
$logLines = Get-Content ".saipen\LOG.md"
$logPattern = "^-\s+(\d{2}[.\/]\d{2}[.\/]\d{2}\s+\d{2}:\d{2}\s+)?\[E-\d+\](\s+\[parent:\s+E-\d+\])?"
foreach ($line in $logLines) {
    if ($line.Trim() -ne "" -and $line -notmatch "^#") {
        Assert-Format ($line -match $logPattern) "LOG.md entry violates Graph Event format: $line"
    }
}
Write-Host "PASS: LOG.md format valid" -ForegroundColor Green

# 4. Check KNOWLEDGE/
if (Test-Path ".saipen\KNOWLEDGE") {
    $knowledgeFiles = Get-ChildItem ".saipen\KNOWLEDGE\*" -Include *.md
    foreach ($file in $knowledgeFiles) {
        $content = Get-Content $file.FullName
        foreach ($line in $content) {
            Assert-Format ($line -notmatch "^-\s+\d{2,4}[-\.]\d{2}[-\.]\d{2}.*(RUN|DEC|H):") "KNOWLEDGE/ leak: found event journal syntax in $($file.Name)"
        }
    }
}
Write-Host "PASS: KNOWLEDGE/ clean" -ForegroundColor Green

Write-Host "Validation complete. Agent is conformant." -ForegroundColor Green
