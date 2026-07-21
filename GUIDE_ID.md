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

| Perintah | Aksi |\n|---|---|\n| `saipen set` | Inisialisasi folder memori |\n| `saipen continue` | Lanjutkan pekerjaan dari catatan |\n| `saipen stop` | Simpan kemajuan & berhenti |\n| `saipen status` | Baca papan |\n| `saipen goal <text>` | Beralih ke tujuan baru |\n| `saipen clean` | Bersihkan repositori |\n| `saipen translate` | Bangun terjemahan |\n| `saipen ship` | Picu aliran rilis |
