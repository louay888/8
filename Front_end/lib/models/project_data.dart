class ProjectInfo {
  final String title;
  final String subtitle;
  final String description;
  final String student;
  final String supervisor;
  final String school;
  final String year;
  final String email;
  final List<String> technologies;
  final List<String> features;

  const ProjectInfo({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.student,
    required this.supervisor,
    required this.school,
    required this.year,
    required this.email,
    required this.technologies,
    required this.features,
  });
}

class UserCardInfo {
  final String name;
  final String role;
  final String team;
  final String avatar;
  final List<String> metadata;

  const UserCardInfo({
    required this.name,
    required this.role,
    required this.team,
    required this.avatar,
    required this.metadata,
  });
}

class TaskItem {
  final String name;
  final String startDate;
  final String? finishDate;
  final double progress;
  final String status;

  const TaskItem({
    required this.name,
    required this.startDate,
    this.finishDate,
    required this.progress,
    required this.status,
  });

  // Factory to parse live Django REST task records cleanly
  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      name: json['title'] ?? '',
      startDate: json['start_date'] ?? 'Sept 2025',
      finishDate: json['finish_date'],
      progress: json['status'] == 'completed' ? 100.0 : 40.0,
      status: json['status'] ?? 'todo',
    );
  }
}

class MilestoneItem {
  final String title;
  final String date;
  final String description;
  final bool isCompleted;

  const MilestoneItem({
    required this.title,
    required this.date,
    required this.description,
    required this.isCompleted,
  });

  // Factory to parse live Django REST timeline records cleanly
  factory MilestoneItem.fromJson(Map<String, dynamic> json) {
    return MilestoneItem(
      title: json['title'] ?? '',
      date: json['date_range'] ?? '',
      description: json['achievement_details'] ?? '',
      isCompleted: json['progress_percentage'] == 100,
    );
  }
}

class ArchitectureStep {
  final String title;
  final String description;
  final String icon;
  final List<String> details;

  const ArchitectureStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.details,
  });
}

class TimelineEvent {
  final String date;
  final String title;
  final String description;
  final bool isCompleted;
  final double progress;

  const TimelineEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.progress,
  });
}

class BibliographyEntry {
  final String title;
  final String authors;
  final String year;
  final String source;
  final String? url;
  final String type;

  const BibliographyEntry({
    required this.title,
    required this.authors,
    required this.year,
    required this.source,
    this.url,
    required this.type,
  });

  // Factory to parse live Django REST bibliography records cleanly
  factory BibliographyEntry.fromJson(Map<String, dynamic> json) {
    return BibliographyEntry(
      title: json['title'] ?? '',
      authors: json['authors'] ?? '',
      year: json['year'] ?? '2026',
      source: json['source_info'] ?? '',
      url: json['url'],
      type: json['ref_type'] ?? 'article',
    );
  }
}

// ==================== STATIC DATA INSTANCES ====================

final projectInfo = const ProjectInfo(
  title: 'SSR',
  subtitle: 'Spectral Super-resolution',
  description: 'SSR vise à améliorer la qualité des images spectrales en utilisant des techniques de super-résolution.',
  student: 'Louay Jamli',
  supervisor: 'Lt Benkhlifa Aymen',
  school: 'EABA - Tunisie',
  year: '2026',
  email: 'jamli.lou3aytn@gmail.com',
  technologies: [
    'Python 3.10',
    'OpenCV',
    'PyTorch',
  ],
  features: [
    'Segmentation HSV calibrée',
    'Segmentation sémantique U-Net',
    'Détection automatique du cadre',
    'Agent IA avec auto-correction',
    'Active Learning adaptatif',
    'Géoréférencement automatique',
    'Export GeoJSON/Shapefile',
    'Interface web interactive',
  ],
);

final userCardInfo = const UserCardInfo(
  name: 'Louay Jamli',
  role: 'Étudiant en Géomatique',
  team: 'EABA Tunisie',
  avatar: '👤',
  metadata: [
    'PFA 2025-2026',
    '2ème Année Géomatique',
    'Encadrant: Lt Benkhlifa Aymen',
  ],
);

final tasksList = [
  const TaskItem(
    name: 'Analyse des besoins & Cadrage',
    startDate: 'Sept 2025',
    finishDate: 'Sept 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Pipeline d\'acquisition & Synthèse',
    startDate: 'Oct 2025',
    finishDate: 'Oct 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Calibration Radiométrique & Réponse Capteur',
    startDate: 'Nov 2025',
    finishDate: 'Nov 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Réseau de Reconstruction (HSCNN+/Transformer)',
    startDate: 'Déc 2025',
    finishDate: 'Déc 2025',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Agent IA & Optimisation des Bandes',
    startDate: 'Jan 2026',
    finishDate: 'Jan 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Super-Résolution Spatio-Spectrale conjointe',
    startDate: 'Fév 2026',
    finishDate: 'Fév 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Application Web de Visualisation (HyperCube)',
    startDate: 'Mars 2026',
    finishDate: 'Mars 2026',
    progress: 100.0,
    status: 'completed',
  ),
  const TaskItem(
    name: 'Validation Métrique & Documentation',
    startDate: 'Avr 2026',
    finishDate: 'Mai 2026',
    progress: 85.0,
    status: 'in_progress',
  ),
];

final milestonesList = [
  const MilestoneItem(
    title: 'Lancement du projet',
    date: 'Sept 2025',
    description: 'Cadrage et spécifications mathématiques de la reconstruction spectrale',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Pipeline de données OK',
    date: 'Oct 2025',
    description: 'Pipeline de chargement des cubes spectraux et simulation RGB fonctionnel',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Fonctions de réponse étalonnées',
    date: 'Nov 2025',
    description: 'Modélisation des fonctions de sensibilité spectrale (CMF) des capteurs cibles',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Modèle SSRR entraîné',
    date: 'Déc 2025',
    description: 'Réseau de neurones entraîné sur ICVL/NTIRE (reconstruction 31 bandes)',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Optimisation Active',
    date: 'Jan 2026',
    description: 'Boucle d\'apprentissage actif pour la sélection des bandes optimales',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Double Résolution Validée',
    date: 'Fév 2026',
    description: 'Algorithme hybride spatial + spectral testé avec succès sur images réelles',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Plateforme Web Déployée',
    date: 'Mars 2026',
    description: 'Interface d\'exploration des cubes spectraux et extraction de signatures opérationnelle',
    isCompleted: true,
  ),
  const MilestoneItem(
    title: 'Soutenance PFA',
    date: 'Mai 2026',
    description: 'Démonstration finale de la reconstruction et soutenance de fin d\'études',
    isCompleted: false,
  ),
];

final architectureSteps = [
  const ArchitectureStep(
    title: 'Prétraitement & Alignement',
    description: 'Préparation des images RGB bas niveau ou multispectrales',
    icon: '📥',
    details: [
      'Correction gamma et normalisation de la réflectance',
      'Alignement sub-pixel des canaux d\'entrée',
      'Extraction de patchs adaptatifs pour l\'entraînement',
      'Enrichissement de données (flips, rotations, bruit gaussien)',
    ],
  ),
  const ArchitectureStep(
    title: 'Modélisation Capteur',
    description: 'Estimation de la dégradation spectrale',
    icon: '🎨',
    details: [
      'Intégration de la fonction de sensibilité spectrale du capteur',
      'Calcul de la matrice de projection Spectral-to-RGB',
      'Estimation de l\'illuminant (algorithmes de White Balance)',
      'Régularisation par contrainte de positivité de la réflectance',
    ],
  ),
  const ArchitectureStep(
    title: 'Reconstruction Spectrale Deep',
    description: 'Inférence par réseau de neurones profond (SSRR)',
    icon: '🧠',
    details: [
      'Architecture ResNet/Transformer optimisée pour la dimension spectrale',
      'Mapping non-linéaire de 3 canaux (RGB) vers N canaux (ex: 31 bandes de 400 à 700nm)',
      'Mécanismes d\'attention spatio-spectrale croisée',
      'Calcul des pertes MRAE (Mean Relative Absolute Error) et SAM (Spectral Angle Mapper)',
    ],
  ),
  const ArchitectureStep(
    title: 'Post-traitement & Régularisation',
    description: 'Lissage et cohérence physique du cube de données',
    icon: '🔧',
    details: [
      'Filtrage bilatéral 3D pour la cohérence spatio-spectrale',
      'Régularisation par variation totale (TV) sur l\'axe des longueurs d\'onde',
      'Correction des aberrations chromatiques résiduelles',
      'Projection sur l\'espace des signatures spectrales admissibles',
    ],
  ),
  const ArchitectureStep(
    title: 'Analyse & Métriques',
    description: 'Évaluation quantitative de la reconstruction',
    icon: '🌍',
    details: [
      'Calcul du score PSNR et SSIM par bande spectrale',
      'Évaluation de la fidélité spectrale via la distance de Wasserstein',
      'Classification/Segmentation test sur cube reconstruit vs cube réel',
      'Génération de masques d\'incertitude de reconstruction',
    ],
  ),
  const ArchitectureStep(
    title: 'Visualisation & Exploitation',
    description: 'Interface utilisateur et export du Hypercube',
    icon: '📤',
    details: [
      'Export aux formats standards (ENVI .hdr, NetCDF, TIFF multi-bandes)',
      'Outil de sélection de profils de réflectance point par point',
      'Rendu interactif en fausses couleurs (composition infrarouge/NDVI)',
      'Correction humaine des anomalies via l\'interface Web',
    ],
  ),
];

final timelineEvents = [
  const TimelineEvent(
    date: 'Septembre 2025',
    title: 'Cadrage de la Super-Résolution Spectrale',
    description: 'Étude de l\'état de l\'art sur le problème inverse de la reconstruction spectrale. Analyse des bases de données NTIRE, ICVL et CAVE.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Octobre 2025',
    title: 'Pipeline Mathématique de Base',
    description: 'Développement du framework Python permettant de simuler des images RGB à partir de cubes spectraux réels en utilisant des fonctions de sensibilité standards.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Novembre 2025',
    title: 'Étalonnage et Calibration',
    description: 'Optimisation du pipeline face au bruit de quantification. Implémentation des contraintes physiques (continuité spectrale et positivité de l\'énergie).',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Décembre 2025',
    title: 'Entraînement des Modèles Profonds',
    description: 'Déploiement et entraînement d\'un modèle basé sur les Transformers spatio-spectraux. Optimisation de la perte d\'angle spectral (SAM) sur GPU.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Janvier 2026',
    title: 'Agent IA & Active Learning',
    description: 'Mise en place d\'un agent intelligent (LangGraph) supervisant l\'entraînement et ajustant dynamiquement les hyperparamètres selon les bandes spectrales critiques.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Février 2026',
    title: 'Super-Résolution Conjointe',
    description: 'Extension de l\'algorithme pour gérer simultanément la super-résolution spatiale (upscaling de l\'image) et la reconstruction spectrale.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Mars 2026',
    title: 'Application Web HyperCube',
    description: 'Création de la plateforme Web (Django + React/Vite) permettant de téléverser une image RGB et de visualiser interactivement son cube spectral reconstruit.',
    isCompleted: true,
    progress: 1.0,
  ),
  const TimelineEvent(
    date: 'Avril-Mai 2026',
    title: 'Validation & Rédaction',
    description: 'Tests de robustesse sur des caméras du commerce non vues à l\'entraînement. Finalisation du rapport de recherche et préparation des supports de présentation.',
    isCompleted: true,
    progress: 0.85,
  ),
];

final bibliographyEntries = [
  const BibliographyEntry(
    title: 'NTIRE 2022 Challenge on Spectral Reconstruction from RGB Items',
    authors: 'Arad B., Blaschko M. B., Danelljan G., et al.',
    year: '2022',
    source: 'CVPR Workshops',
    url: 'https://openaccess.thecvf.com/content/CVPR2022W/NTIRE/html/Arad_NTIRE_2022_Spectral_Reconstruction_Challenge_CVPRW_2022_paper.html',
    type: 'Conference',
  ),
  const BibliographyEntry(
    title: 'HSCNN+: Advanced CNN Variants for Dense Spectral Reconstruction from RGB',
    authors: 'Shi Z., Chen C., Xiong Z., Liu D., Wu F.',
    year: '2018',
    source: 'IEEE CVPR Workshops',
    url: 'https://doi.org/10.1109/CVPRW.2018.00133',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'Hyperspectral Image Reconstruction using Spatio-Spectral Transformers',
    authors: 'Cai Y., Lin J., Lin X., Hao Z.',
    year: '2022',
    source: 'ECCV',
    url: 'https://arxiv.org/abs/2207.08053',
    type: 'Article',
  ),
  const BibliographyEntry(
    title: 'ICVL Hyperspectral Image Dataset',
    authors: 'Arad B., Ben-Shahar O.',
    year: '2016',
    source: 'Ben-Gurion University of the Negev',
    url: 'https://www.cs.bgu.ac.il/~icvl/home/',
    type: 'Dataset',
  ),
  const BibliographyEntry(
    title: 'Spectral Angle Mapper (SAM) Metric Definitions',
    authors: 'Kruse F. A., et al.',
    year: '1993',
    source: 'Remote Sensing of Environment',
    url: 'https://doi.org/10.1016/0034-4257(93)90013-X',
    type: 'Documentation',
  ),
];