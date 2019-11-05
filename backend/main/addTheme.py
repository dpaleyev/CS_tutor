import requests
from bs4 import BeautifulSoup
from .models import Task
from .serializers import ThemeSerializer, TaskSerializer


def add(url, name): #добавление темы
    req = requests.get(url)
    theme_serializer = ThemeSerializer(data={"name": name, "url": url})
    theme_serializer.is_valid()
    theme = theme_serializer.save()
    bsObj = BeautifulSoup(req.text)
    nameList = bsObj.findAll("tr", {"class":"content"})
    print(name)
    for name in nameList[1:]:
        num = str(name.get_text()[:4])
        num = int(num)
        task = Task.objects.get(num=num)
        task.theme.add(theme)
        print(task.pk)
