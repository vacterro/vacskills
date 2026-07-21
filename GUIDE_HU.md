<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Útmutató (Magyar)

Ide figyelj, újonc. A probléma egyszerű: az AI ügynökeidnek aranyhal memóriája van.

A **SAIPEN** egy jegyzetfüzet a projekted `.saipen/` mappájában.

## Gyors indulás

1. **Telepítse gépenként egyszer:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Projekt indítása:**
> `saipen set`

3. **Munka:**
> `saipen`

## Parancsok

| Parancs | Művelet |\n|---|---|\n| `saipen set` | Memóriamappa inicializálása |\n| `saipen continue` | Munka folytatása jegyzetekből |\n| `saipen stop` | Folyamat mentése és leállítás |\n| `saipen status` | Tábla olvasása |\n| `saipen goal <text>` | Váltás új célra |\n| `saipen clean` | Adattár tisztítása |\n| `saipen translate` | Fordítás készítése |\n| `saipen ship` | Kiadási folyamat elindítása |
