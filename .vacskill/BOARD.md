# Board
## DOING
## TODO
## DONE
- [x] T-026 core reliability audit: 6 logic holes fixed within line budget (verified: 23-key grep PASS, 250 lines exact, conf: high)
- [x] T-025 drop _archive_versions (verified: identical twins == v1.2.2, recoverable via git show v1.2.2:VAC/SKILL.md PASS, conf: high)
- [x] T-022 style persistence anchor: STYLE.md Persistence + SKILL loads it upfront (verified: grep anchors PASS, conf: med — дрейф проверяется только временем)
- [x] T-023 git tags as release archive, 17 versions tagged retroactively (verified: git show v1.0.0:VERSION -> 1.0.0 PASS, conf: high)
- [x] T-024 compress SKILL.md 281->249, no rules lost + self line-cap rule (verified: 17-key grep all present PASS, conf: high)
- [x] T-021 rename VAC -> vacskill entirely: skill/folder/memory/repo + injector migration (verified: 6 installs name=vacskill, 0 legacy leftovers, gh repo view PASS, conf: high)
- [x] T-015 injector inject.ps1 + inject.sh + README one-shot section (verified: live run 8 already + 2 copied PASS)
- [x] T-006 maintain SKILL.md: loop-free caps, token discipline, publish gating (verified: structure grep PASS)
- [x] T-007 ship v1.1.0 (verified: ls-remote after push)
- [x] T-005 make repo portable: generic paths, LICENSE, clone-first install (verified: grep clean PASS)
- [x] T-001 ship gate: secrets scan + structure check (verified: grep clean PASS)
- [x] T-002 release files VERSION 1.0.0 + CHANGELOG + README polish (verified: files exist, links valid)
- [x] T-003 git init + initial commit (verified: git log shows 39a5ece)
- [x] T-004 create remote github.com/vacterro + push (verified: git ls-remote origin main -> 39a5ece PASS)








