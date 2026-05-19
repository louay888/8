// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr'),
    Locale('ar')
  ];

  /// Titre principal de l'application
  ///
  /// In fr, this message translates to:
  /// **'CartoVec - PFA'**
  String get appTitle;

  /// Label de navigation vers la page d'accueil
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get home;

  /// Label de navigation vers la page architecture
  ///
  /// In fr, this message translates to:
  /// **'Architecture'**
  String get architecture;

  /// Label de navigation vers la page chronologie
  ///
  /// In fr, this message translates to:
  /// **'Chronologie'**
  String get timeline;

  /// Label de navigation vers la page bibliographie
  ///
  /// In fr, this message translates to:
  /// **'Bibliographie'**
  String get bibliography;

  /// Nom du projet
  ///
  /// In fr, this message translates to:
  /// **'CartoVec'**
  String get projectTitle;

  /// Sous-titre décrivant le projet
  ///
  /// In fr, this message translates to:
  /// **'Vectorisation Automatique de Cartes Historiques'**
  String get projectSubtitle;

  /// Description détaillée du projet pour la page d'accueil
  ///
  /// In fr, this message translates to:
  /// **'CartoVec transforme des cartes topographiques raster scannées en couches vectorielles exploitables dans un SIG. Le projet combine un pipeline Python (OpenCV/PyTorch/GeoPandas), un agent IA basé sur LangGraph, une API Django REST et une interface React/Vite avec Leaflet.'**
  String get projectDescription;

  /// Label pour le nom de l'étudiant
  ///
  /// In fr, this message translates to:
  /// **'Étudiant'**
  String get student;

  /// Label pour le nom du superviseur
  ///
  /// In fr, this message translates to:
  /// **'Encadrant'**
  String get supervisor;

  /// Label pour le nom de l'école
  ///
  /// In fr, this message translates to:
  /// **'École'**
  String get school;

  /// Label pour l'année académique
  ///
  /// In fr, this message translates to:
  /// **'Année'**
  String get year;

  /// Titre de la section navigation
  ///
  /// In fr, this message translates to:
  /// **'Explorer le projet'**
  String get exploreProject;

  /// Titre de la section présentation
  ///
  /// In fr, this message translates to:
  /// **'Présentation'**
  String get presentation;

  /// Label pour la liste des technologies
  ///
  /// In fr, this message translates to:
  /// **'Technologies'**
  String get technologies;

  /// Label pour la liste des fonctionnalités
  ///
  /// In fr, this message translates to:
  /// **'Fonctionnalités'**
  String get features;

  /// Titre de la section pipeline
  ///
  /// In fr, this message translates to:
  /// **'Pipeline de Traitement'**
  String get pipeline;

  /// Étape 1: Prétraitement de l'image
  ///
  /// In fr, this message translates to:
  /// **'Prétraitement'**
  String get preprocessing;

  /// Étape 2: Segmentation par couleur HSV
  ///
  /// In fr, this message translates to:
  /// **'Segmentation Couleur'**
  String get colorSegmentation;

  /// Étape 3: Segmentation par IA (U-Net)
  ///
  /// In fr, this message translates to:
  /// **'Segmentation IA'**
  String get aiSegmentation;

  /// Étape 4: Nettoyage et vectorisation
  ///
  /// In fr, this message translates to:
  /// **'Post-traitement'**
  String get postProcessing;

  /// Étape 5: Attribution de coordonnées géographiques
  ///
  /// In fr, this message translates to:
  /// **'Géoréférencement'**
  String get georeferencing;

  /// Étape 6: Export des résultats
  ///
  /// In fr, this message translates to:
  /// **'Export & Visualisation'**
  String get export;

  /// Titre de la section technologies
  ///
  /// In fr, this message translates to:
  /// **'Stack Technique'**
  String get techStack;

  /// Titre de la section flux de données
  ///
  /// In fr, this message translates to:
  /// **'Flux de Données'**
  String get dataFlow;

  /// Label pour l'indicateur de progression
  ///
  /// In fr, this message translates to:
  /// **'Progression'**
  String get progress;

  /// Badge pour une étape terminée
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get completed;

  /// Badge pour une étape en cours
  ///
  /// In fr, this message translates to:
  /// **'En cours'**
  String get inProgress;

  /// Titre de la section progression globale
  ///
  /// In fr, this message translates to:
  /// **'Progression Globale'**
  String get globalProgress;

  /// Texte affichant le nombre d'étapes complétées
  ///
  /// In fr, this message translates to:
  /// **'étapes complétées'**
  String get stepsCompleted;

  /// Titre de la section métriques
  ///
  /// In fr, this message translates to:
  /// **'Métriques Clés'**
  String get keyMetrics;

  /// Titre de la section références
  ///
  /// In fr, this message translates to:
  /// **'Références Bibliographiques'**
  String get references;

  /// Titre de la section remerciements
  ///
  /// In fr, this message translates to:
  /// **'Remerciements'**
  String get acknowledgments;

  /// Titre de la section licences
  ///
  /// In fr, this message translates to:
  /// **'Licences'**
  String get licenses;

  /// Label pour les informations de contact
  ///
  /// In fr, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Label indiquant le type de projet
  ///
  /// In fr, this message translates to:
  /// **'Projet de Fin d\'\'Année'**
  String get pfaProject;

  /// Filière d'études
  ///
  /// In fr, this message translates to:
  /// **'Géomatique'**
  String get geomatics;

  /// Niveau d'études
  ///
  /// In fr, this message translates to:
  /// **'2ème Année'**
  String get secondYear;

  /// Type de référence: jeu de données
  ///
  /// In fr, this message translates to:
  /// **'Dataset'**
  String get dataset;

  /// Type de référence: article scientifique
  ///
  /// In fr, this message translates to:
  /// **'Article'**
  String get article;

  /// Type de référence: compétition
  ///
  /// In fr, this message translates to:
  /// **'Compétition'**
  String get competition;

  /// Type de référence: bibliothèque logicielle
  ///
  /// In fr, this message translates to:
  /// **'Bibliothèque'**
  String get library;

  /// Type de référence: documentation
  ///
  /// In fr, this message translates to:
  /// **'Documentation'**
  String get documentation;

  /// Type de données: image raster
  ///
  /// In fr, this message translates to:
  /// **'Raster'**
  String get raster;

  /// Interface de programmation
  ///
  /// In fr, this message translates to:
  /// **'API'**
  String get api;

  /// Partie interface utilisateur
  ///
  /// In fr, this message translates to:
  /// **'Frontend'**
  String get frontend;

  /// Partie serveur et traitement
  ///
  /// In fr, this message translates to:
  /// **'Backend'**
  String get backend;

  /// Résultat final du pipeline
  ///
  /// In fr, this message translates to:
  /// **'Output'**
  String get output;

  /// Message de chargement
  ///
  /// In fr, this message translates to:
  /// **'Chargement...'**
  String get loading;

  /// Message d'erreur
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get error;

  /// Bouton de réessai
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// Bouton de fermeture
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// Bouton d'ouverture
  ///
  /// In fr, this message translates to:
  /// **'Ouvrir'**
  String get open;

  /// Bouton de détails
  ///
  /// In fr, this message translates to:
  /// **'Détails'**
  String get details;

  /// Bouton pour voir plus
  ///
  /// In fr, this message translates to:
  /// **'Plus'**
  String get more;

  /// Bouton pour voir moins
  ///
  /// In fr, this message translates to:
  /// **'Moins'**
  String get less;

  /// Bouton navigation suivante
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// Bouton navigation précédente
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get previous;

  /// Bouton de recherche
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get search;

  /// Bouton de filtrage
  ///
  /// In fr, this message translates to:
  /// **'Filtrer'**
  String get filter;

  /// Bouton de tri
  ///
  /// In fr, this message translates to:
  /// **'Trier'**
  String get sort;

  /// Option de filtre: tout
  ///
  /// In fr, this message translates to:
  /// **'Tout'**
  String get all;

  /// Option de filtre: aucun
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get none;

  /// Titre du sélecteur de langue
  ///
  /// In fr, this message translates to:
  /// **'Choisir la langue'**
  String get selectLanguage;

  /// Nom de la langue française
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get french;

  /// Nom de la langue arabe
  ///
  /// In fr, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// Nom de la langue anglaise
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get english;

  /// Message de confirmation de changement de langue
  ///
  /// In fr, this message translates to:
  /// **'Langue changée avec succès'**
  String get languageChanged;

  /// Texte de copyright
  ///
  /// In fr, this message translates to:
  /// **'CartoVec © 2025'**
  String get copyright;

  /// Texte de droits réservés
  ///
  /// In fr, this message translates to:
  /// **'Tous droits réservés'**
  String get rightsReserved;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
