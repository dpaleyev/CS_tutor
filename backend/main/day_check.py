import requests
from bs4 import BeautifulSoup
from datetime import datetime
import pytz

m = {'Jan': 1, "Feb": 2, "Mar": 3, "Apr": 4, "May": 5, "Jun": 6, "Jul": 7, "Aug": 8, "Sep": 9, "Oct": 10, "Nov": 11, "Dec": 12}

def date_res(profile):
    judge_id = int(profile.judge_id)
    daten = datetime.now(pytz.timezone('Asia/Yekaterinburg')).date()
    a = [0]*7
    url = 'https://timus.online/status.aspx?author=%d&status=accepted&count=200' % judge_id
    req = requests.get(url)
    bsObj = BeautifulSoup(req.text)
    nameList = bsObj.findAll("tr", {"class": "even"})
    for name in nameList:
        bs = BeautifulSoup(str(name))
        date = bs.findAll("td", {"class": "date"})
        date = str(date)[:-13]
        date = date[date.rfind('>')+1:]
        date = [i for i in date.split(' ')]
        d = datetime(int(date[2]), m[date[1]], int(date[0])).date()
        t = (daten-d).days
        if t >= 7:
            break
        a[t] += 1

    nameList = bsObj.findAll("tr", {"class": "odd"})
    for name in nameList:
        bs = BeautifulSoup(str(name))
        date = bs.findAll("td", {"class": "date"})
        date = str(date)[:-13]
        date = date[date.rfind('>')+1:]
        date = [i for i in date.split(' ')]
        d = datetime(int(date[2]), m[date[1]], int(date[0])).date()
        t = (daten-d).days
        if t >= 7:
            break
        a[t] += 1

    return a
