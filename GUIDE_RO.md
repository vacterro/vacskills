<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Ghid SAIPEN (Română)

Ascultă, începătorule. Problema e simplă: agenții tăi AI au memoria unui peștișor auriu.

**SAIPEN** este un caiet în folderul `.saipen/` din proiectul tău.

## Pornire rapidă

1. **Instalați o dată per mașină:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Porniți proiectul:**
> `saipen set`

3. **Lucru:**
> `saipen`

## Comenzi

| Comandă | Acțiune |\n|---|---|\n| `saipen set` | Inițializați folderul de memorie |\n| `saipen continue` | Reluați lucrul din note |\n| `saipen stop` | Salvați progresul și opriți |\n| `saipen status` | Citiți panoul |\n| `saipen goal <text>` | Treceți la noul obiectiv |\n| `saipen clean` | Curățați depozitul |\n| `saipen translate` | Construcție traducere |\n| `saipen ship` | Declanșați fluxul de lansare |
