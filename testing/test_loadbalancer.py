#!/usr/bin/env python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import requests
from bs4 import BeautifulSoup
from time import sleep


def getResponse(url):
    response = requests.get(url)
    return response

def parseResponse(response):
    soup = BeautifulSoup(response, "lxml")
    paragraphs = soup.find_all('p')
    for i in paragraphs:
        print(i.get_text())

def testSequence(amount, request_pause):
    for i in range(amount):
        r = getResponse("http://localhost:3000")
        print(r.status_code)
        parseResponse(r.text)
        sleep(request_pause)

if __name__ == "__main__":
    testSequence(20,0.1)
