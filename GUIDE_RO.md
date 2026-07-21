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

| Comandă | Acțiune |
|---|---|
| `saipen set` | Inițializați folderul de memorie |
| `saipen continue` | Reluați lucrul din note |
| `saipen stop` | Salvați progresul și opriți |
| `saipen status` | Citiți panoul |
| `saipen goal <text>` | Treceți la noul obiectiv |
| `saipen clean` | Curățați depozitul |
| `saipen translate` | Construcție traducere |
| `saipen ship` | Declanșați fluxul de lansare |
