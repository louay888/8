# 🎯 CartoVec Presentation - Flutter App
## Résumé du Projet Livré

---

## 📋 Structure des 4 Pages

### Page 1: Accueil (`home_screen.dart`)
- **Design**: Dégradé teal avec glassmorphism
- **Contenu**:
  - Titre "CartoVec" + sous-titre
  - Carte de présentation du projet avec description détaillée
  - Tags des technologies utilisées (OpenCV, PyTorch, Django, React...)
  - Informations étudiant/encadrant/école
  - 3 cartes de navigation vers les autres pages
- **Navigation**: MaterialPageRoute vers Architecture, Chronologie, Bibliographie

### Page 2: Architecture (`architecture_screen.dart`)
- **Design**: AppBar expandable avec gradient rouge, fond gris clair
- **Contenu**:
  - **Pipeline Flow**: 6 étapes visuelles (Raster → Prétraitement → Segmentation → Vectorisation → Géoréf. → GeoJSON)
  - **Étapes détaillées**: 6 ExpansionTile avec détails techniques
    - Prétraitement (détection cadre, débruitage)
    - Segmentation Couleur (HSV: routes, végétation, eau...)
    - Segmentation IA (U-Net ResNet34, 6 classes SEMAP)
    - Post-traitement (CC labeling, squelettisation)
    - Géoréférencement (GCPs, transformation affine)
    - Export & Visualisation (GeoJSON, Leaflet)
  - **Stack Technique**: 3 catégories (Vision & IA, Géospatial, Web)
  - **Flux de Données**: Frontend → API → Pipeline → Output

### Page 3: Chronologie (`timeline_screen.dart`)
- **Design**: AppBar expandable avec gradient rouge, timeline verticale
- **Contenu**:
  - **Progression Globale**: CircularPercentIndicator + LinearProgressIndicator
  - **Timeline**: 8 événements de Sept 2024 à Mai 2025
    - Lancement → Pipeline base → Calibration HSV → Segmentation IA
    - Agent IA & Active Learning → Détection cadre → Web App → Tests
  - **Métriques**: Grid de 6 métriques clés
    - 13,561 échantillons SEMAP
    - 8 cartes calibrées
    - ~0.65 mIoU U-Net
    - 6 classes SEMAP
    - 15+ modules Python
    - 4 endpoints API

### Page 4: Bibliographie (`bibliography_screen.dart`)
- **Design**: AppBar expandable avec gradient vert
- **Contenu**:
  - **Carte projet**: Informations PFA, étudiant, encadrant
  - **Références**: 8 entrées bibliographiques avec type coloré
    - SEMAP Dataset (EPFL, Zenodo)
    - Article Petitpierre (arXiv 2026)
    - SODUCO Benchmark (BnF)
    - ICDAR 2021 Competition
    - SMP, LangGraph, OpenCV, GeoPandas
  - **Remerciements**: Kamel BENRAIS, EABA, EPFL, BnF/SODUCO, OSM
  - **Licences**: CC BY 4.0, MIT, Apache 2.0, BSD

---

## 🎨 Design System

| Élément | Valeur |
|---------|--------|
| Couleur principale | `#0d6b78` (Teal) |
| Couleur accent | `#e74c3c` (Rouge) |
| Couleur succès | `#27ae60` (Vert) |
| Police | Inter (Google Fonts) |
| Design | Material 3 + Glassmorphism |

---

## 📦 Dépendances Flutter

```yaml
dependencies:
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  percent_indicator: ^4.2.3
  url_launcher: ^6.2.2
```

---

## 🚀 Commandes de Lancement

```bash
cd cartovec_presentation
flutter pub get
flutter run
```

---

## 📁 Fichiers Créés (10 fichiers, ~68 KB)

| Fichier | Taille | Description |
|---------|--------|-------------|
| `pubspec.yaml` | 926 B | Configuration projet |
| `main.dart` | 723 B | Point d'entrée |
| `project_data.dart` | 8.9 KB | Données du projet |
| `home_screen.dart` | 10.0 KB | Page d'accueil |
| `architecture_screen.dart` | 15.8 KB | Architecture & fonctionnement |
| `timeline_screen.dart` | 15.0 KB | Chronologie & avancement |
| `bibliography_screen.dart` | 14.9 KB | Bibliographie & références |
| `README.md` | 1.4 KB | Documentation |
| `SETUP.md` | 2.7 KB | Guide d'installation |
| `ASSETS_GUIDE.md` | 1.1 KB | Guide des assets |

---

## ✅ Fonctionnalités Implémentées

- [x] Navigation entre 4 pages
- [x] Design responsive avec CustomScrollView/Slivers
- [x] ExpansionTile pour contenu détaillé
- [x] Timeline verticale avec indicateurs de progression
- [x] Circular & Linear progress indicators
- [x] Grid de métriques
- [x] Cards avec ombres et bordures
- [x] URL launcher pour liens bibliographiques
- [x] Gradient backgrounds et glassmorphism
- [x] Chip/tags pour technologies
- [x] Icons Material Design
- [x] Typography Google Fonts (Inter)

---

## 🔧 Prochaines Étapes Recommandées

1. **Ajouter des images** dans `assets/images/` (logo, captures écran)
2. **Télécharger les polices** Inter et Cairo dans `assets/fonts/`
3. **Tester sur appareil physique** Android/iOS
4. **Build release** pour distribution APK
5. **Ajouter des animations** Lottie pour transitions
6. **Internationalisation** (i18n) si besoin multilingue

---

**Auteur**: Oussama CHOUAIBI | **Encadrant**: Kamel BENRAIS  
**École**: EABA Tunisie | **Année**: 2024-2025
