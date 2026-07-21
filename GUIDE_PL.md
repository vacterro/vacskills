<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Przewodnik SAIPEN (Polski)

SAIPEN to notatnik pamięci w folderze `.saipen/` dla agentów AI.

## Szybki Start

1. **Zainstaluj raz na maszynę:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Uruchom w projekcie:**
> `saipen set`

3. **Praca:**
> `saipen`

## Polecenia

| Polecenie | Akcja |
|---|---|
| `saipen set` | Zainicjuj folder pamięci `.saipen/` |
| `saipen continue` | Wznów pracę z notatek |
| `saipen stop` | Zapisz postęp i zatrzymaj |
| `saipen status` | Odczytaj tablicę i status |
| `saipen goal <text>` | Przejdź do nowego celu |
| `saipen clean` | Głębokie czyszczenie repozytorium |
| `saipen translate` | Izolowana kompilacja tłumaczeń w 22 językach |
| `saipen ship` | Uruchom przepływ wydania |
