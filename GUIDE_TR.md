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

| Komut | Eylem |
|---|---|
| `saipen set` | Bellek klasörünü başlat |
| `saipen continue` | Notlardan çalışmaya devam et |
| `saipen stop` | İlerlemeyi kaydet & dur |
| `saipen status` | Panoyu oku |
| `saipen goal <text>` | Yeni hedefe geç |
| `saipen clean` | Depoyu temizle |
| `saipen translate` | Çeviri derlemesi |
| `saipen ship` | Yayın akışını tetikle |
