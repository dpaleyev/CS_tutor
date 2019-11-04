from django.urls import path
from .addTheme import add
from .apiviews import LessonList, LessonDetail, UserCreate, Statistic, NoteList, ToDo
from rest_framework.authtoken import views

urlpatterns = [
    path("login/", views.obtain_auth_token, name="login"),
    path("register/", UserCreate.as_view(), name="registration"),
    path("todo/", ToDo.as_view(), name="todo"),
    path("statistics/", Statistic.as_view(), name="statistics"),
    path("notes/", NoteList.as_view(), name="notes"),
    path("lesson/theme/<int:theme>/", LessonList.as_view(), name="lessons_list"),
    path("lesson/<int:pk>/", LessonDetail.as_view(), name="lessons_detail")
]



