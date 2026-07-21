<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Guide (Svenska)

SAIPEN är en minnesanteckningsbok i mappen `.saipen/` för AI-agenter.

## Snabbstart

1. **Installera en gång per maskin:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Starta projekt:**
> `saipen set`

3. **Arbeta:**
> `saipen`

## Kommandon

| Kommando | Åtgärd |
|---|---|
| `saipen set` | Initiera minnesmapp `.saipen/` |
| `saipen continue` | Återuppta arbete från anteckningar |
| `saipen stop` | Spara framsteg & stanna |
| `saipen status` | Läs tavla & status |
| `saipen goal <text>` | Växla till nytt mål |
| `saipen clean` | Djupgående rensning av arkiv |
| `saipen translate` | Isolerad 22-språkig översättningsbygge |
| `saipen ship` | Utlös lanseringsflöde |
