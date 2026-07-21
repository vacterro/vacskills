<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Vodič (Hrvatski)

Slušaj, početniče. Problem je jednostavan: tvoji AI agenti imaju pamćenje zlatne ribice.

**SAIPEN** je bilježnica u mapi `.saipen/` u vašem projektu.

## Brzi početak

1. **Instalirajte jednom po stroju:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Pokreni projekt:**
> `saipen set`

3. **Rad:**
> `saipen`

## Naredbe

| Naredba | Akcija |\n|---|---|\n| `saipen set` | Inicijalizirajte mapu memorije |\n| `saipen continue` | Nastavi rad iz bilješki |\n| `saipen stop` | Spremi napredak i zaustavi |\n| `saipen status` | Pročitaj ploču |\n| `saipen goal <text>` | Prebaci na novi cilj |\n| `saipen clean` | Očisti repozitorij |\n| `saipen translate` | Izrada prijevoda |\n| `saipen ship` | Pokreni tok izdanja |
