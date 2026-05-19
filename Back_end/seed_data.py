import os
import django

# Configuration de l'environnement Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings')
django.setup()

from pipeline_api.models import UserProfile, ProjectTask, TimelineMilestone, BibliographyReference

def seed_database():
    print("🚀 Début du remplissage complet de la base de données...")

    # 1. REMPLISSAGE DU PROFIL UTILISATEUR
    print("👤 Initialisation du profil...")
    profile_data = {
        "full_name": "Louay Jamli",
        "email": "jamli.lou3aytn@gmail.com",
        "supervisor": "Benkhlifa Aymen",
        "institution": "EABA - Tunisie",
        "project_title": "Spectral super-resolution for cartographic image enhancement",
        
        
    }
    
    # Utilisation de l'email pour éviter les doublons
    UserProfile.objects.get_or_create(email=profile_data["email"], defaults=profile_data)
    print("✅ Profil inséré ou déjà existant.")

    # 2. REMPLISSAGE DES TÂCHES
    tasks = [
        {"title": "Analyse des besoins & cadrage", "description": "", "status": "completed"},
        {"title": "Pipeline Python de base", "description": "", "status": "completed"},
        {"title": "Calibration HSV", "description": "", "status": "completed"},
        {"title": "Segmentation IA (U-Net)", "description": "", "status": "completed"},
        {"title": "Agent IA & Active Learning", "description": "", "status": "completed"},
        {"title": "Détection du cadre cartographique", "description": "", "status": "completed"},
        {"title": "Application Web (Django + React)", "description": "", "status": "completed"},
        {"title": "Tests & Documentation", "description": "Tests sur cartes réelles tunisiennes et algériennes. Rédaction de la documentation technique et du mémoire.", "status": "in_progress"},
    ]
    
    for t in tasks:
        ProjectTask.objects.get_or_create(title=t["title"], defaults=t)
    print("✅ Tâches insérées.")

    # 3. REMPLISSAGE DES JALONS (TIMELINE)
    milestones = [
        {"date_range": "Sept 2025", "title": "Lancement du projet", "achievement_details": "Définition du cadrage et analyse des besoins", "progress_percentage": 100},
        {"date_range": "Oct 2025", "title": "Pipeline fonctionnel", "achievement_details": "Pipeline Python de base opérationnel", "progress_percentage": 100},
        {"date_range": "Nov 2025", "title": "Calibration HSV", "achievement_details": "Calibration sur 8 cartes militaires réelles", "progress_percentage": 100},
        {"date_range": "Déc 2025", "title": "Modèle IA entraîné", "achievement_details": "U-Net ResNet34 entraîné sur SEMAP (13,561 échantillons)", "progress_percentage": 100},
        {"date_range": "Jan 2026", "title": "Agent IA opérationnel", "achievement_details": "Agent LangGraph avec boucle Perceive→Plan→Execute→QA", "progress_percentage": 100},
        {"date_range": "Fév 2026", "title": "Détection cadre OK", "achievement_details": "Algorithme two-stage testé sur 8 cartes réelles", "progress_percentage": 100},
        {"date_range": "Mars 2026", "title": "Web App déployée", "achievement_details": "Backend Django REST + Frontend React/Vite opérationnels", "progress_percentage": 100},
        {"date_range": "Mai 2026", "title": "Soutenance PFA", "achievement_details": "Présentation finale et livraison du projet", "progress_percentage": 85},
    ]

    for m in milestones:
        TimelineMilestone.objects.get_or_create(title=m["title"], defaults=m)
    print("✅ Chronologie insérée.")

    # 4. REMPLISSAGE DE LA BIBLIOGRAPHIE
    bibliography = [
        {"title": "Semantic Segmentation Map Dataset (Semap)", "authors": "Petitpierre R., Gomez Donoso D., Kriesel B.", "source_info": "EPFL, Zenodo", "ref_type": "dataset", "url": "https://doi.org/10.5281/zenodo.16164781"},
        {"title": "Generalizable Multiscale Segmentation of Heterogeneous Map Collections", "authors": "Petitpierre R.", "source_info": "arXiv:2603.05037", "ref_type": "article", "url": "https://doi.org/10.48550/arXiv.2603.05037"},
        {"title": "Benchmark_historical_map_vectorization", "authors": "SODUCO (Sorbonne Université)", "source_info": "GitHub / BnF Gallica", "ref_type": "dataset", "url": "https://github.com/soduco/Benchmark_historical_map_vectorization"},
        {"title": "ICDAR 2021 Competition on Historical Map Segmentation", "authors": "Chazalon J., Carlinet E., Chen Y., et al.", "source_info": "arXiv:2105.13265", "ref_type": "article", "url": "https://arxiv.org/abs/2105.13265"},
        {"title": "Segmentation Models PyTorch", "authors": "Pavel Iakubovskii", "source_info": "GitHub", "ref_type": "framework", "url": "https://github.com/qubvel/segmentation_models.pytorch"},
        {"title": "LangGraph - Build agentic applications", "authors": "LangChain", "source_info": "Documentation officielle", "ref_type": "framework", "url": "https://langchain-ai.github.io/langgraph/"},
        {"title": "OpenCV - Computer Vision Library", "authors": "Intel / OpenCV Team", "source_info": "opencv.org", "ref_type": "framework", "url": "https://opencv.org/"},
        {"title": "GeoPandas - Python tools for geographic data", "authors": "GeoPandas Team", "source_info": "geopandas.org", "ref_type": "framework", "url": "https://geopandas.org/"}
    ]

    for b in bibliography:
        BibliographyReference.objects.get_or_create(title=b["title"], defaults=b)
    print("✅ Bibliographie insérée.")
    print("\n🎉 Base de données initialisée avec succès !")

if __name__ == '__main__':
    seed_database()