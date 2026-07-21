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

| Parancs | Művelet |
|---|---|
| `saipen set` | Memóriamappa inicializálása |
| `saipen continue` | Munka folytatása jegyzetekből |
| `saipen stop` | Folyamat mentése és leállítás |
| `saipen status` | Tábla olvasása |
| `saipen goal <text>` | Váltás új célra |
| `saipen clean` | Adattár tisztítása |
| `saipen translate` | Fordítás készítése |
| `saipen ship` | Kiadási folyamat elindítása |
