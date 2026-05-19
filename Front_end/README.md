# CartoVec Presentation

Application Flutter de présentation du projet **CartoVec** (PFA 2024-2025) - Vectorisation Automatique de Cartes Historiques.

## 🌍 Internationalisation (i18n)

L'application supporte **2 langues** avec support complet RTL :

| Langue | Code | Écriture |
|--------|------|----------|
| 🇫🇷 Français | `fr` | LTR |
| 🇸🇦 Arabe | `ar` | RTL |

### Changement de langue
- Sélecteur de langue dans l'AppBar (drapeau 🇫🇷/🇸🇦)
- Changement dynamique sans redémarrage
- SnackBar de confirmation

## 📱 Pages

1. **Page d'accueil** - Présentation du projet, technologies, infos étudiant
2. **Architecture** - Pipeline 6 étapes, stack technique, flux de données
3. **Chronologie** - Timeline sept 2024 → mai 2025, métriques clés
4. **Bibliographie** - 8 références, remerciements, licences

## 🚀 Installation

### Prérequis
- Flutter SDK 3.0+
- Dart SDK
- Android Studio / VS Code

### Étapes

```bash
# Cloner le projet
cd cartovec_presentation

# Installer les dépendances
flutter pub get

# Générer les localisations
flutter gen-l10n

# Lancer l'application
flutter run
```

## 📦 Dépendances

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  google_fonts: ^6.1.0
  percent_indicator: ^4.2.3
  url_launcher: ^6.2.2
  flutter_svg: ^2.0.9
  cupertino_icons: ^1.0.6
```

## 🎨 Design

- **Palette** : Teal (`#0d6b78`)
- **Polices** : Inter (FR) / Cairo (AR)
- **Style** : Material 3 + Glassmorphism
- **RTL** : Support complet arabe

## 📝 Documentation

- [SETUP.md](SETUP.md) - Guide d'installation détaillé
- [I18N_GUIDE.md](I18N_GUIDE.md) - Guide d'internationalisation
- [ASSETS_GUIDE.md](ASSETS_GUIDE.md) - Guide des assets

## 🏗️ Architecture i18n

```
lib/
├── l10n/
│   ├── app_fr.arb          # Traduction française
│   ├── app_ar.arb          # Traduction arabe
│   └── app_localizations.dart  # Généré auto
├── widgets/
│   └── language_selector.dart
└── main.dart
```

## 📄 Auteur

**Oussama CHOUAIBI**  
Étudiant en Géomatique - EABA Tunisie  
Encadrant : Kamel BENRAIS (ELFOULADH)

## 📧 Contact

ochouaibi1919@gmail.com

---

**CartoVec © 2026** - Projet de Fin d'Année
