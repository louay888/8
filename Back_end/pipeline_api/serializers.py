from rest_framework import serializers
from .models import UserProfile, ProjectTask, TimelineMilestone, BibliographyReference

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class ProjectTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProjectTask
        fields = '__all__'

class TimelineMilestoneSerializer(serializers.ModelSerializer):
    class Meta:
        model = TimelineMilestone
        fields = '__all__'

class BibliographyReferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = BibliographyReference
        fields = '__all__'