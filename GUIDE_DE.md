<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# SAIPEN Anleitung (Deutsch)

Hör zu, Neuling. Das Problem ist einfach: Deine AI-Agenten haben das Gedächtnis eines Goldfisches.

**SAIPEN** ist einfach ein Notizbuch im Ordner `.saipen/` direkt in deinem Projekt.

## Schnellstart

1. **Einmal pro Maschine installieren:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Im Projekt starten:**
> `saipen set`

3. **Arbeiten:**
> `saipen`

## Befehle

| Befehl | Aktion |
|---|---|
| `saipen set` | Speicherordner `.saipen/` initialisieren |
| `saipen continue` | Arbeit anhand von Notizen fortsetzen |
| `saipen stop` | Fortschritt speichern & anhalten |
| `saipen status` | Board & Status lesen |
| `saipen goal <text>` | Zu neuem Ziel wechseln |
| `saipen clean` | Tiefe Repository-Bereinigung |
| `saipen translate` | Isolierter 22-Sprachen-Übersetzungs-Build |
| `saipen ship` | Release-Flow auslösen |
