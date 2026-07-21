<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Panduan SAIPEN (Bahasa Indonesia)

Dengar, pemula. Masalahnya sederhana: agen AI Anda memiliki ingatan ikan mas.

**SAIPEN** adalah buku catatan di folder `.saipen/` di proyek Anda.

## Mulai Cepat

1. **Instal sekali per mesin:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Mulai proyek:**
> `saipen set`

3. **Bekerja:**
> `saipen`

## Perintah

| Perintah | Aksi |
|---|---|
| `saipen set` | Inisialisasi folder memori |
| `saipen continue` | Lanjutkan pekerjaan dari catatan |
| `saipen stop` | Simpan kemajuan & berhenti |
| `saipen status` | Baca papan |
| `saipen goal <text>` | Beralih ke tujuan baru |
| `saipen clean` | Bersihkan repositori |
| `saipen translate` | Bangun terjemahan |
| `saipen ship` | Picu aliran rilis |
