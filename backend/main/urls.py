from django.urls import path

from .apiviews import LessonList, LessonDetail

urlpatterns = [
    path("lesson/theme/<int:theme>/", LessonList.as_view(), name="lessons_list"),
    path("lesson/<int:pk>/", LessonDetail.as_view(), name="lessons_detail")
]