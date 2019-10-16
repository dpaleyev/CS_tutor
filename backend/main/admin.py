from django.contrib import admin
from .models import Profile, Task, Lesson, Theme, Note
admin.site.register(Profile)
admin.site.register(Task)
admin.site.register(Lesson)
admin.site.register(Theme)
admin.site.register(Note)