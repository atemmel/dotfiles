#!/bin/python
import requests
import urllib.request
import sys
from bs4 import BeautifulSoup

def isdate(string):
    if len(string) < 5:
        return False
    return string[0].isdigit() and string[1].isdigit() and string[3].isdigit() and string[4].isdigit();

url = "https://cloud.timeedit.net/miun/web/student/ri1X5058w1502vQQ5YZYQQ7Y06y8Z639757.html"
days = ["Må", "Ti", "On", "To", "Fr", "Lö", "Sö"]
n_days = 1  #N days to fetch events
fields = 7  #Fields per event
wc = 5      #Max events per day
dummy = 1   #Leading fields to ignore

if len(sys.argv) > 1:
    try:
        n_days = int(sys.argv[1])
    except ValueError:
        print("Expected integer argument, got string")
        exit(1)

response = requests.get(url)
if(response.status_code != 200):
    print("Error:", response)
    exit(1)

soup = BeautifulSoup(response.text, "html.parser")
info = soup.findAll("td", {"class": ["time", "leftRounded", "columnLine"]}, limit=n_days*fields*wc+dummy)
del info[0:dummy]
info = filter(len, info)

snipe = 0
for r in info:
    #Identify day
    for day in days:
        if r.text.startswith(day):
            snipe += 1

    #If looped long enough
    if snipe > n_days:
        break

    #Add whitespace
    if isdate(r.text):
        print()

    if(len(r.text) > 64):
        print(r.text[0:64] + "...")
    else:
        print(r.text)
