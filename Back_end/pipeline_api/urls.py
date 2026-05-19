from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserProfileViewSet, ProjectTaskViewSet, TimelineMilestoneViewSet
from .views import BibliographyReferenceViewSet  # Add to top imports



router = DefaultRouter()
router.register(r'profile', UserProfileViewSet)
router.register(r'tasks', ProjectTaskViewSet)
router.register(r'timeline', TimelineMilestoneViewSet)
router.register(r'bibliography', BibliographyReferenceViewSet)

urlpatterns = [
    path('', include(router.urls)),
]