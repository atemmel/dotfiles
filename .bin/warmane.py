#!/bin/python
import requests
import urllib.request
from bs4 import BeautifulSoup

url = "https://www.warmane.com/"

response = requests.get(url)
if(response.status_code != 200):
    print("Error:", response)
    exit(1)

soup = BeautifulSoup(response.text, "html.parser")
info = soup.findAll("td", {"class": "statistics"}, limit=3)

if len(info) != 3:
    exit()

print("Icecrown currently has", info[-1].text.strip())
