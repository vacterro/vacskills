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

| Εντολή | Ενέργεια |
|---|---|
| `saipen set` | Αρχικοποίηση φακέλου μνήμης |
| `saipen continue` | Συνέχιση εργασίας από σημειώσεις |
| `saipen stop` | Αποθήκευση & διακοπή |
| `saipen status` | Ανάγνωση πίνακα |
| `saipen goal <text>` | Αλλαγή σε νέο στόχο |
| `saipen clean` | Καθαρισμός αποθετηρίου |
| `saipen translate` | Δημιουργία μετάφρασης |
| `saipen ship` | Εκκίνηση ροής έκδοσης |
