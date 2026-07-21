<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Οδηγός SAIPEN (Ελληνικά)

Άκου, πρωτάρη. Το πρόβλημα είναι απλό: οι πράκτορες AI έχουν μνήμη χρυσόψαρου.

Το **SAIPEN** είναι ένα σημειωματάριο στον φάκελο `.saipen/` στο έργο σας.

## Γρήγορη Εκκίνηση

1. **Εγκατάσταση μία φορά ανά μηχάνημα:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Έναρξη έργου:**
> `saipen set`

3. **Εργασία:**
> `saipen`

## Εντολές

| Εντολή | Ενέργεια |\n|---|---|\n| `saipen set` | Αρχικοποίηση φακέλου μνήμης |\n| `saipen continue` | Συνέχιση εργασίας από σημειώσεις |\n| `saipen stop` | Αποθήκευση & διακοπή |\n| `saipen status` | Ανάγνωση πίνακα |\n| `saipen goal <text>` | Αλλαγή σε νέο στόχο |\n| `saipen clean` | Καθαρισμός αποθετηρίου |\n| `saipen translate` | Δημιουργία μετάφρασης |\n| `saipen ship` | Εκκίνηση ροής έκδοσης |
