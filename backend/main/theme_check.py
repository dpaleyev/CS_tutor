from .models import Profile, Theme, Task

def theme_res(profile):#получение выполненных задач по теме, формирование словаря
    a = []
    for i in Theme.objects.all():
        d = {}
        d["name"] = i.name
        d["url"] = i.url
        d["compl"] = profile.completed_tasks.filter(theme=i).count()
        d["tasks"] = Task.objects.filter(theme=i).count()
        a.append(d)
    return a
