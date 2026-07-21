<p align="center">
  <img src="assets/SAIPEN_design1.png" alt="SAIPEN Guide Title" width="800"/>
</p>

# Guide SAIPEN (Français)

Écoute ici, recrue. Le problème est simple: vos agents IA ont la mémoire d'un poisson rouge.

**SAIPEN** est un cahier résistant dans le dossier `.saipen/` de votre projet.

## Démarrage Rapide

1. **Installer une fois par machine:**
```bash
git clone https://github.com/vacterro/saipen
cd saipen
powershell -ExecutionPolicy Bypass -File .\bootstrap\inject.ps1     # Windows
bash bootstrap/inject.sh                                            # macOS / Linux
```

2. **Démarrer le projet:**
> `saipen set`

3. **Travailler:**
> `saipen`

## Commandes

| Commande | Action |
|---|---|
| `saipen set` | Initialiser le dossier mémoire `.saipen/` |
| `saipen continue` | Reprendre le travail depuis les notes |
| `saipen stop` | Sauvegarder la progression et arrêter |
| `saipen status` | Lire le tableau et l'état |
| `saipen goal <text>` | Pivoter vers un nouvel objectif |
| `saipen clean` | Nettoyage approfondi du dépôt |
| `saipen translate` | Construction de traduction isolée en 22 langues |
| `saipen ship` | Déclencher le flux de publication |
