<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Sprievodca SAIPEN (Slovenčina)

Počúvaj, nováčik. Problém je jednoduchý: tvoji AI agenti majú pamäť zlatej rybky.

**SAIPEN** je zápisník v priečinku `.saipen/` vo vašom projekte.

## Rýchly štart

1. **Nainštalujte raz na počítač:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Spustiť projekt:**
> `saipen set`

3. **Práca:**
> `saipen`

## Príkazy

| Príkaz | Akcia |\n|---|---|\n| `saipen set` | Inicializovať priečinok pamäte |\n| `saipen continue` | Obnoviť prácu z poznámok |\n| `saipen stop` | Uložiť pokrok a zastaviť |\n| `saipen status` | Čítať nástenku |\n| `saipen goal <text>` | Prepnúť na nový cieľ |\n| `saipen clean` | Vyčistiť repozitár |\n| `saipen translate` | Zostavenie prekladu |\n| `saipen ship` | Spustiť tok vydania |
