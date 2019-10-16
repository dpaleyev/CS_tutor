from django.urls import path

from .apiviews import LessonList, LessonDetail

urlpatterns = [
    path("polls/<int:theme>", LessonList.as_view(), name="lessons_list"),
    path("polls/<int:pk>/", LessonDetail.as_view(), name="lessons_detail")
]