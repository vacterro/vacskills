<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Průvodce SAIPEN (Čeština)

Poslouchej, nováčku. Problém je jednoduchý: tvoji AI agenti mají paměť zlaté rybky.

**SAIPEN** je zápisník ve složce `.saipen/` ve tvém projektu.

## Rychlý start

1. **Nainstalujte jednou na počítač:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Spustit projekt:**
> `saipen set`

3. **Práce:**
> `saipen`

## Příkazy

| Příkaz | Akce |\n|---|---|\n| `saipen set` | Inicializovat složku paměti |\n| `saipen continue` | Obnovit práci z poznámek |\n| `saipen stop` | Uložit pokrok & zastavit |\n| `saipen status` | Číst nástěnku |\n| `saipen goal <text>` | Přepnout na nový cíl |\n| `saipen clean` | Vyčistit repozitář |\n| `saipen translate` | Sestavit překlady |\n| `saipen ship` | Spustit tok vydání |
