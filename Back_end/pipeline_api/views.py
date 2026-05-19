from rest_framework import viewsets
from .models import UserProfile, ProjectTask, TimelineMilestone, BibliographyReference
from .serializers import (
    UserProfileSerializer, 
    ProjectTaskSerializer, 
    TimelineMilestoneSerializer, 
    BibliographyReferenceSerializer
)

class UserProfileViewSet(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

class ProjectTaskViewSet(viewsets.ModelViewSet):
    queryset = ProjectTask.objects.all().order_by('-updated_at')
    serializer_class = ProjectTaskSerializer

class TimelineMilestoneViewSet(viewsets.ModelViewSet):
    queryset = TimelineMilestone.objects.all().order_by('id')
    serializer_class = TimelineMilestoneSerializer

class BibliographyReferenceViewSet(viewsets.ModelViewSet):
    queryset = BibliographyReference.objects.all().order_by('id')
    serializer_class = BibliographyReferenceSerializer