<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN 가이드 (한국어)

SAIPEN은 프로젝트 내 `.saipen/` 폴더에 위치한 AI 에이전트용 지속성 메모장입니다.

## 빠른 시작

1. **머신당 한 번 설치:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **프로젝트 시작:**
> `saipen set`

3. **작업:**
> `saipen`

## 명령어

| 명령어 | 동작 |
|---|---|
| `saipen set` | 메모리 폴더 `.saipen/` 초기화 |
| `saipen continue` | 노트에서 작업 재개 |
| `saipen stop` | 진행 상황 저장 및 중지 |
| `saipen status` | 보드 및 상태 읽기 |
| `saipen goal <text>` | 새로운 목표로 전환 |
| `saipen clean` | 저장소 딥 클린 |
| `saipen translate` | 격리된 22개 언어 번역 빌드 |
| `saipen ship` | 릴리스 플로우 트리거 |
