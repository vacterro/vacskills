# saipen injector -- installs saipen as default protocol on every agentic system found.
# Run from the clone dir:  powershell -ExecutionPolicy Bypass -File .\inject.ps1
# Idempotent: safe to re-run any time (skips what's already installed).
# Also migrates pre-3.0 installs named "VAC".

param([string]$SkillHome = (Join-Path (Split-Path $PSScriptRoot) "saipen"))

$ErrorActionPreference = "Continue"
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
function Write-NoBom([string]$file, [string]$text) {
  if ((Test-Path $file) -and -not (Test-Path "$file.bak")) { Copy-Item $file "$file.bak" -Force }
  [System.IO.File]::WriteAllText($file, $text, $Utf8NoBom)
}
try { $SkillHome = (Resolve-Path $SkillHome).Path } catch {
  Write-Host "FATAL: saipen folder not found at $SkillHome" -ForegroundColor Red; exit 1
}
if (-not (Test-Path (Join-Path $SkillHome "RFC.md"))) {
  Write-Host "FATAL: RFC.md missing in $SkillHome" -ForegroundColor Red; exit 1
}

$block = @"

<!-- SAIPEN:BEGIN -->
## saipen protocol (global)
On "saipen set" / "saipen ..." (short alias "vac ...") commands, or when
project root contains .saipen/: read $SkillHome\RFC.md + $SkillHome\STYLE.md
and follow them.
Memory: .saipen/ at project root - read .saipen/STATE.md before work;
checkpoint BOARD + STATE after every ticket, LOG line after every run.
Path missing (new machine)? clone github.com/vacterro/saipen.
UI work: also obey $SkillHome\UI.md (Win95 dark golden, Verdana, no AA).
<!-- SAIPEN:END -->
"@

# Strip a genuinely legacy <!-- ASP:BEGIN --> / <!-- VACSKILL:BEGIN --> block.
# Current <!-- SAIPEN:BEGIN --> blocks are handled separately by Add-Block,
# which compares content instead of stripping unconditionally -- otherwise
# every re-run would strip+rewrite an already-current block and misreport
# it as "migrated from VAC".
function Remove-LegacyBlock([string]$file) {
  if (-not (Test-Path $file)) { return $false }
  $text = Get-Content $file -Raw -Encoding utf8
  $changed = $false
  if ($text -match '<!-- ASP:BEGIN -->') {
    $text = [regex]::Replace($text, '(?s)\s*<!-- ASP:BEGIN -->.*?<!-- ASP:END -->\s*', "`n")
    $changed = $true
  }
  if ($text -match '<!-- VACSKILL:BEGIN -->') {
    $text = [regex]::Replace($text, '(?s)\s*<!-- VACSKILL:BEGIN -->.*?<!-- VACSKILL:END -->\s*', "`n")
    $changed = $true
  }
  if ($changed) {
    Write-NoBom $file ($text.TrimEnd() + "`n")
  }
  return $changed
}

function Add-Block([string]$file) {
  if (Test-Path $file) {
    $text = Get-Content $file -Raw -Encoding utf8
    if ($text -match '(?s)<!-- SAIPEN:BEGIN -->.*?<!-- SAIPEN:END -->') {
      $existing = $Matches[0]
      if ($existing.Trim() -eq $block.Trim()) { return "already" }
      $clean = [regex]::Replace($text, '(?s)\s*<!-- SAIPEN:BEGIN -->.*?<!-- SAIPEN:END -->\s*', "`n")
      Write-NoBom $file ($clean.TrimEnd() + $block + "`n")
      return "block refreshed"
    }
    $migrated = Remove-LegacyBlock $file
    $text = Get-Content $file -Raw -Encoding utf8
    Write-NoBom $file ($text.TrimEnd() + $block + "`n")
    return $(if ($migrated) { "migrated from VAC" } else { "block added" })
  }
  $dir = Split-Path $file
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  Write-NoBom $file ($block.TrimStart() + "`n")
  return "file created"
}

# Drop a pre-3.0 skill dir. Junctions are unlinked; real dirs deleted only when
# they are ours (SKILL.md with saipen/VAC frontmatter inside).
function Remove-LegacySkill([string]$path) {
  if (-not (Test-Path $path)) { return $false }
  $item = Get-Item $path -Force
  if ($item.LinkType) { cmd /c rmdir "$path" | Out-Null; return $true }
  $marker = Join-Path $path "SKILL.md"
  if (Test-Path $marker) {
    if (Select-String -Path $marker -Pattern "^name:\s*(VAC|vacskill)\s*$" -Quiet) {
      Remove-Item -Recurse -Force $path; return $true
    }
  }
  return $false
}

function Copy-Skill([string]$dst, [string]$legacy) {
  if ($legacy) { Remove-LegacySkill $legacy | Out-Null }
  if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Force $dst | Out-Null }
  Copy-Item (Join-Path $SkillHome "SKILL.md"),(Join-Path $SkillHome "RFC.md"),(Join-Path $SkillHome "UI.md"),(Join-Path $SkillHome "STYLE.md") $dst -Force
  return "copied (re-run after updates)"
}

$h = $env:USERPROFILE
$report = New-Object System.Collections.ArrayList

# --- Claude Code ---
if (Test-Path "$h\.claude") {
  [void]$report.Add(@("Claude Code skill",     (Copy-Skill "$h\.claude\skills\saipen" "$h\.claude\skills\VAC")))
  [void]$report.Add(@("Claude Code CLAUDE.md", (Add-Block    "$h\.claude\CLAUDE.md")))
} else { [void]$report.Add(@("Claude Code", "not installed - skip")) }

# --- OpenCode ---
if (Test-Path "$h\.config\opencode") {
  [void]$report.Add(@("OpenCode skill",     (Copy-Skill "$h\.config\opencode\skills\saipen" "$h\.config\opencode\skills\vac")))
  [void]$report.Add(@("OpenCode AGENTS.md", (Add-Block    "$h\.config\opencode\AGENTS.md")))
} else { [void]$report.Add(@("OpenCode", "not installed - skip")) }

# --- Codex CLI ---
if (Test-Path "$h\.codex") {
  [void]$report.Add(@("Codex skill",     (Copy-Skill "$h\.codex\skills\saipen" "$h\.codex\skills\vac")))
  [void]$report.Add(@("Codex AGENTS.md", (Add-Block    "$h\.codex\AGENTS.md")))
} else { [void]$report.Add(@("Codex", "not installed - skip")) }

# --- Gemini CLI ---
if (Test-Path "$h\.gemini") {
  [void]$report.Add(@("Gemini GEMINI.md", (Add-Block "$h\.gemini\GEMINI.md")))
} else { [void]$report.Add(@("Gemini", "not installed - skip")) }

# --- Generic ~/.agents/skills (FreeBuff etc.) ---
# Copy, lowercase: these readers skip junctions and uppercase dirs.
if (Test-Path "$h\.agents\skills") {
  Remove-LegacySkill "$h\.agents\skills\VAC" | Out-Null
  [void]$report.Add(@("~/.agents skills", (Copy-Skill "$h\.agents\skills\saipen" "$h\.agents\skills\vac")))
} else { [void]$report.Add(@("~/.agents", "not installed - skip")) }

# --- Antigravity plugins (copy: IDE locks dirs, junction impossible while open) ---
$plugRoot = "$h\.gemini\config\plugins"
if (Test-Path $plugRoot) {
  Get-ChildItem $plugRoot -Directory | ForEach-Object {
    $skillsDir = Join-Path $_.FullName "skills"
    if (Test-Path $skillsDir) {
      [void]$report.Add(@("Antigravity [$($_.Name)]", (Copy-Skill (Join-Path $skillsDir "saipen") (Join-Path $skillsDir "VAC"))))
    }
  }
}

# --- Aider ---
$aider = "$h\.aider.conf.yml"
$skillPath = Join-Path $SkillHome "RFC.md"
if (Get-Command aider -ErrorAction SilentlyContinue) {
  if (Test-Path $aider) {
    $conf = Get-Content $aider -Raw -Encoding utf8
    if ($conf -match '[\\/](VAC|vacskill)[\\/]SKILL\.md') {   # pre-4.0 path -> repoint
      Write-NoBom $aider ($conf -replace '.*[\\/](VAC|vacskill)[\\/]SKILL\.md', "  - $skillPath")
      [void]$report.Add(@("Aider conf", "migrated to RFC.md"))
    } elseif ($conf -match [regex]::Escape($skillPath)) {
      [void]$report.Add(@("Aider conf", "already"))
    } elseif ($conf -notmatch '(?m)^read:') {
      Write-NoBom $aider ($conf.TrimEnd() + "`n`n# saipen protocol auto-loaded`nread:`n  - $skillPath`n")
      [void]$report.Add(@("Aider conf", "read: appended"))
    } else {
      [void]$report.Add(@("Aider conf", "has own read: - add manually: $skillPath"))
    }
  } else {
    Write-NoBom $aider "# saipen protocol auto-loaded`nread:`n  - $skillPath`n"
    [void]$report.Add(@("Aider conf", "created"))
  }
} else { [void]$report.Add(@("Aider", "not installed - skip")) }

# --- Report ---
Write-Host ""
Write-Host "saipen injector report (source: $SkillHome)" -ForegroundColor Yellow
Write-Host ("-" * 60)
foreach ($r in $report) {
  $color = if ($r[1] -match "FAILED|manually") { "Red" }
           elseif ($r[1] -match "already|skip") { "DarkGray" } else { "Green" }
  Write-Host ("{0,-28} {1}" -f $r[0], $r[1]) -ForegroundColor $color
}
Write-Host ("-" * 60)
Write-Host "Done. Test: open any project in any agent, say: saipen set" -ForegroundColor Yellow
