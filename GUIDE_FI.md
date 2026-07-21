<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Opas (Suomi)

SAIPEN on muistilehtiö `.saipen/`-kansiossa tekoälyagenteille.

## Pika-aloitus

1. **Asenna kerran konetta kohti:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Käynnistä projekti:**
> `saipen set`

3. **Työskentele:**
> `saipen`

## Komennot

| Komento | Toiminto |
|---|---|
| `saipen set` | Alusta muisti-kansio `.saipen/` |
| `saipen continue` | Jatka työtä muistiinpanoista |
| `saipen stop` | Tallenna edistyminen ja pysäytä |
| `saipen status` | Lue taulu ja tila |
| `saipen goal <text>` | Siirry uuteen tavoitteeseen |
| `saipen clean` | Syvä tietovaraston siivous |
| `saipen translate` | Eristetty 22 kielen käännöksen rakennus |
| `saipen ship` | Käynnistä julkaisuvirta |
