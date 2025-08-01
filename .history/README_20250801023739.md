# Notre Jeu Super Bien - Jeu d'Aventure Avancé

Un jeu d'aventure textuel développé en Pascal avec Free Pascal/Lazarus, inspiré de l'univers de Skyrim.

## 📋 Description

Notre Jeu Super Bien est un jeu d'aventure en mode console qui propose une expérience immersive avec :
- Création de personnage avec différentes races et classes
- Système de combat
- Gestion d'inventaire
- Système de quêtes
- Interface graphique ASCII
- Sauvegarde/chargement de partie
- Ambiance sonore

## 🎮 Fonctionnalités

- **Création de personnage** : Choisissez votre race, classe et attributs
- **Exploration** : Naviguez dans le monde de Blancherive
- **Combat** : Système de combat au tour par tour
- **Inventaire** : Gérez vos objets et équipements
- **Quêtes** : Accomplissez diverses missions
- **Histoire** : Suivez un scénario immersif
- **Sauvegarde** : Système de sauvegarde JSON
- **Audio** : Musiques d'ambiance (.wav, .ogg)

## 🛠️ Technologies utilisées

- **Langage** : Object Pascal (Free Pascal)
- **IDE** : Lazarus
- **Audio** : Windows MMSystem
- **Format de sauvegarde** : JSON
- **Graphisme** : Interface console ASCII

## 📁 Structure du projet

```
├── NotreJeuSuperBien.pas      # Programme principal
├── GestionEcran.pas           # Gestion de l'affichage console
├── unitcreationperso.pas      # Création de personnage
├── unitcombat.pas             # Système de combat
├── unitinventaire.pas         # Gestion de l'inventaire
├── unitmap.pas                # Navigation dans le monde
├── unithistoire.pas           # Gestion de l'histoire
├── quetes.pas                 # Système de quêtes
├── unitsave.pas               # Sauvegarde/chargement
├── unitinterface.pas          # Interface utilisateur
├── data/                      # Données du jeu
│   ├── scenario/              # Fichiers de scénario
│   └── logo/                  # Images et logos
├── sound/                     # Fichiers audio
└── amazdoom/                  # Polices personnalisées
```

## 🚀 Installation et compilation

### Prérequis

- Free Pascal Compiler (FPC) 3.0+
- Lazarus IDE (recommandé)
- Windows (pour le support audio MMSystem)

### Compilation

1. **Avec Lazarus :**
   - Ouvrez le fichier `jeuMinimal.lpi` dans Lazarus
   - Compilez avec F9 ou Build > Build

2. **En ligne de commande :**
   ```bash
   fpc NotreJeuSuperBien.pas
   ```

### Exécution

```bash
NotreJeuSuperBien.exe
```

## 🎯 Comment jouer

1. **Démarrage** : Lancez l'exécutable
2. **Menu principal** : Choisissez entre nouvelle partie, charger ou quitter
3. **Création de personnage** : Sélectionnez vos caractéristiques
4. **Exploration** : Utilisez les touches directionnelles pour vous déplacer
5. **Combat** : Suivez les instructions à l'écran
6. **Sauvegarde** : Sauvegardez votre progression depuis le menu

## ⌨️ Contrôles

- **Flèches directionnelles** : Navigation
- **Entrée** : Valider
- **Échap** : Menu/Retour
- **Touches spécifiques** : Selon le contexte (combat, inventaire, etc.)

## 💾 Système de sauvegarde

Le jeu utilise un système de sauvegarde JSON qui préserve :
- Statistiques du personnage
- Inventaire et équipement
- Progression des quêtes
- Position dans le monde

## 🎵 Audio

Le jeu inclut des musiques d'ambiance :
- `main.wav` : Musique principale
- `ambiance.ogg` : Sons d'ambiance
- Support des formats WAV et OGG

## 🐛 Problèmes connus

- Le jeu nécessite Windows pour le support audio
- La console doit être configurée en UTF-8 pour l'affichage des caractères spéciaux

## 📝 Licence

Projet éducatif - Libre d'utilisation à des fins pédagogiques.

## 🎯 Objectifs pédagogiques

Ce projet démontre :
- Programmation orientée objet en Pascal
- Gestion de fichiers et sérialisation JSON
- Interface utilisateur console
- Architecture modulaire
- Gestion d'état de jeu
- Integration multimédia basique
