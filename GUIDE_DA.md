<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Guide (Dansk)

SAIPEN er en hukommelsesnotesbog i mappen `.saipen/` til AI-agenter.

## Hurtig Start

1. **Installer én gang pr. maskine:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Start projekt:**
> `saipen set`

3. **Arbejde:**
> `saipen`

## Kommandoer

| Kommando | Handling |
|---|---|
| `saipen set` | Initialiser hukommelsesmappe `.saipen/` |
| `saipen continue` | Genoptag arbejde fra noter |
| `saipen stop` | Gem fremskridt & stop |
| `saipen status` | Læs tavle & status |
| `saipen goal <text>` | Skift til nyt mål |
| `saipen clean` | Dybdegående oprydning af repository |
| `saipen translate` | Isoleret 22-sproget oversættelsesbyg |
| `saipen ship` | Udløs udgivelsesflow |
