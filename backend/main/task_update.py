import requests
from bs4 import BeautifulSoup
from .models import Profile, Task


def update(prof):
    judge_id = int(prof.judge_id)
    url = 'https://timus.online/author.aspx?id=%d&sort=difficulty' % judge_id
    req = requests.get(url)

    bsObj = BeautifulSoup(req.text)
    nameList = bsObj.findAll("td", {"class":"accepted"})

    print(nameList)
    for name in nameList:
        num = int(name.get_text()[:4])
        t = Task.objects.get(num=num)
        prof.completed_tasks.add(t)

    nameList = bsObj.findAll("td", {"class":"tried"})

    print(nameList)
    for name in nameList:
        num = int(name.get_text()[:4])
        t = Task.objects.get(num=num)
        prof.wa_tasks.add(t)
        print(num)
