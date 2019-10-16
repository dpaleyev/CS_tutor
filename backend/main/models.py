from django.db import models
from django.contrib.auth.models import User

class Theme(models.Model):
    name = models.CharField(max_length=60)
    url = models.URLField()

class Task(models.Model):
    num = models.IntegerField(primary_key=True)
    title = models.CharField(max_length=60)
    theme = models.ManyToManyField(Theme)

class Note(models.Model):
    task = models.ForeignKey('Task', on_delete=models.CASCADE)
    idea = models.TextField()
    modified = models.DateField(auto_now=True)

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    judge_id = models.CharField(max_length=30, blank=True)
    completed_tasks = models.ManyToManyField(Task, related_name="compl+")
    wa_tasks = models.ManyToManyField(Task, related_name="wa+")
    todo_tasks = models.ManyToManyField(Task, related_name="todo+")
    notes = models.ManyToManyField(Note)

class Lesson(models.Model):
    title = models.CharField(max_length=60)
    theme = models.IntegerField()
    text = models.TextField()
    tasks = models.ManyToManyField(Task)

