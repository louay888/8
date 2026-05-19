"""
URL configuration for cartovec_backend project.
"""
from django.contrib import admin
from django.urls import path, include  # Make sure 'include' is imported!

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include("pipeline_api.urls")),  # This links your app's URLs to /api/
]