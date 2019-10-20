from django.urls import path
from .addTheme import add
from .apiviews import LessonList, LessonDetail, UserCreate
from rest_framework.authtoken import views

#add("https://timus.online/problemset.aspx?space=1&tag=geometry", "Геометрия")

urlpatterns = [
    path("login/", views.obtain_auth_token, name="login"),
    path("register/", UserCreate.as_view(), name="registration"),
    path("lesson/theme/<int:theme>/", LessonList.as_view(), name="lessons_list"),
    path("lesson/<int:pk>/", LessonDetail.as_view(), name="lessons_detail")
]



