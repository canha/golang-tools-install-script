#!/usr/bin/env python3
#coding=utf-8
import requests
import re

resp = requests.get("https://golang.org/dl/?mode=json").text
print(re.findall("(?<=go)[.,0-9]+(?=.src.tar.gz)", resp)[0], end="")
