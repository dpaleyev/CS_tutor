from rest_framework.views import APIView
from rest_framework.response import Response
from django.shortcuts import get_object_or_404


from .models import Lesson
from .serializers import LessonSerializer

class LessonList(APIView):
    def get(self, request, theme):
        lessons = Lesson.objects.filter(theme=theme)
        data = LessonSerializer(lessons, many=True).data
        return Response(data)

class LessonDetail(APIView):
    def get(self, request, pk):
        lesson = get_object_or_404(Lesson, pk=pk)
        data = LessonSerializer(lesson).data
        return Response(data)


