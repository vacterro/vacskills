<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Kılavuzu (Türkçe)

Dinle, acemi. Sorun basit: yapay zeka ajanlarının hafızası bir japon balığı gibidir.

**SAIPEN** projenizdeki `.saipen/` klasöründe bulunan bir not defteridir.

## Hızlı Başlangıç

1. **Makine başına bir kez kurun:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Projede başlat:**
> `saipen set`

3. **Çalış:**
> `saipen`

## Komutlar

| Komut | Eylem |\n|---|---|\n| `saipen set` | Bellek klasörünü başlat |\n| `saipen continue` | Notlardan çalışmaya devam et |\n| `saipen stop` | İlerlemeyi kaydet & dur |\n| `saipen status` | Panoyu oku |\n| `saipen goal <text>` | Yeni hedefe geç |\n| `saipen clean` | Depoyu temizle |\n| `saipen translate` | Çeviri derlemesi |\n| `saipen ship` | Yayın akışını tetikle |
