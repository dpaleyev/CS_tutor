import requests
from bs4 import BeautifulSoup
from .models import Profile, Task

def get_to_do(prof):
    judge_id = int(prof.judge_id)
    url = 'https://timus.online/author.aspx?id=%d&sort=difficulty' % judge_id
    req = requests.get(url)

    bsObj = BeautifulSoup(req.text)
    nameList = bsObj.findAll("td", {"class": "empty"})
    i = 0
    for name in nameList:
        if i >= 10:
            break
        num = int(name.get_text()[:4])
        t = Task.objects.get(num=num)
        prof.todo_tasks.add(t)
        i += 1

def get_tasks(prof):
    a = []
    b = []
    for i in prof.todo_tasks.all():
        a.append(i.num)
    for i in prof.wa_tasks.all():
        b.append(i.num)
    return a, b

