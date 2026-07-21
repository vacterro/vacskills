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

| Príkaz | Akcia |
|---|---|
| `saipen set` | Inicializovať priečinok pamäte |
| `saipen continue` | Obnoviť prácu z poznámok |
| `saipen stop` | Uložiť pokrok a zastaviť |
| `saipen status` | Čítať nástenku |
| `saipen goal <text>` | Prepnúť na nový cieľ |
| `saipen clean` | Vyčistiť repozitár |
| `saipen translate` | Zostavenie prekladu |
| `saipen ship` | Spustiť tok vydania |
