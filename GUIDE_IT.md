<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Guida SAIPEN (Italiano)

SAIPEN è un taccuino di memoria persistente nella cartella `.saipen/` per agenti AI.

## Avvio Rapido

1. **Installa una volta per macchina:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Avvia progetto:**
> `saipen set`

3. **Lavorare:**
> `saipen`

## Comandi

| Comando | Azione |
|---|---|
| `saipen set` | Inizializza cartella memoria `.saipen/` |
| `saipen continue` | Riprendi lavoro dagli appunti |
| `saipen stop` | Salva progresso e ferma |
| `saipen status` | Leggi bacheca e stato |
| `saipen goal <text>` | Passa al nuovo obiettivo |
| `saipen clean` | Pulizia profonda del repository |
| `saipen translate` | Compilazione isolata per traduzione in 22 lingue |
| `saipen ship` | Avvia flusso di rilascio |
