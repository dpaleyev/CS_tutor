from rest_framework.views import APIView
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from rest_framework import status
import json
from django.http import JsonResponse
from rest_framework import generics


from .models import Lesson, Profile, Note, Task
from .serializers import LessonSerializer, UserSerializer, ProfileSerializer, NoteSerializer
from .day_check import date_res
from .theme_check import theme_res
from .task_update import update
from .gtodo import get_to_do, get_tasks


class NoteList(APIView):
    def get(self, request):
        user = request.user
        p = Profile.objects.get(user=user)
        notes = p.notes
        data = NoteSerializer(notes, many=True).data
        return Response(data)
    def post(self, request):
        user = request.user
        p = Profile.objects.get(user=user)
        data = json.loads(request.body)
        idea = data["idea"]
        task = data["task"]
        note = Note(idea=idea, task=task)
        note.save()
        p.notes.add(note)
        return Response(status=status.HTTP_201_CREATED)
    def put(self, request):
        data = json.loads(request.body)
        id = data["id"]
        idea = data["idea"]
        task = data["task"]
        n = Note.objects.get(pk=id)
        n.idea = idea
        n.task = task
        n.save()
        return Response(status=status.HTTP_201_CREATED)
    def delete(self, request):
        data = json.loads(request.body)
        id = data["id"]
        Note.objects.get(pk=id).delete()
        return Response(status=status.HTTP_200_OK)


class Statistic(APIView):
    def get(self, request):
        user = request.user
        p = Profile.objects.get(user=user)
        update(p)
        days = date_res(p)
        compl = p.completed_tasks.count()
        tried = p.wa_tasks.count()
        theme_prog = theme_res(p)
        data = {
            "completed": compl,
            "tried": tried,
            "day_statistic": days,
            "theme_statistic": theme_prog,
        }
        return JsonResponse(data)

class ToDo(APIView):
    def get(self, request):
        user = request.user
        p = Profile.objects.get(user=user)
        update(p)
        get_to_do(p)
        a, b = get_tasks(p)
        data = {
            "todo": a,
            "wa": b
        }
        return JsonResponse(data)


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


class UserCreate(APIView):
    authentication_classes = ()
    permission_classes = ()

    def post(self, request):
        data = json.loads(request.body)
        email = data["email"]
        username = data["username"]
        password = data["password"]
        judge_id = data["judge_id"]
        serializer = UserSerializer(data={"email": email, "username": username, "password": password})
        if serializer.is_valid():

            user = serializer.save()
            p = Profile(user=user, judge_id=judge_id)
            p.save()
            if user:
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            else:
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)





