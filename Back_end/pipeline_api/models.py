from django.db import models

class UserProfile(models.Model):
    """Saves student info, supervisor info, and institution names."""
    full_name = models.CharField(max_length=150)
    email = models.EmailField(unique=True)
    supervisor = models.CharField(max_length=150)
    institution = models.CharField(max_length=200, default="EABA Tunisie")
    project_title = models.CharField(max_length=255, default="CartoVec")
    project_description = models.TextField()

    def __str__(self):
        return self.full_name

class ProjectTask(models.Model):
    """Gestion des tâches: manages development items and processing modules."""
    STATUS_CHOICES = [
        ('todo', 'To Do'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='todo')
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.title} ({self.status})"

class TimelineMilestone(models.Model):
    """Chronologies: manages historical progress targets over given periods."""
    date_range = models.CharField(max_length=100)
    title = models.CharField(max_length=200)
    achievement_details = models.TextField()
    progress_percentage = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.date_range} - {self.title}"

class BibliographyReference(models.Model):
    """Bibliographie: Stores project references, datasets, and academic papers."""
    REFERENCE_TYPES = [
        ('dataset', 'Dataset'),
        ('article', 'Article'),
        ('framework', 'Framework/Library'),
    ]
    title = models.CharField(max_length=255)
    authors = models.CharField(max_length=255, blank=True)
    source_info = models.CharField(max_length=255)
    ref_type = models.CharField(max_length=20, choices=REFERENCE_TYPES, default='article')
    url = models.URLField(max_length=500, blank=True)

    def __str__(self):
        return f"[{self.get_ref_type_display()}] {self.title}"