#!/bin/bash
python3 -m virtualenv venv
#Download latest chromedriver
chromeLatest=$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget https://chromedriver.storage.googleapis.com/$chromeLatest/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d venv/bin/

#Download latest geckodriver
latestFirefox=$(curl -s https://api.github.com/repos/mozilla/geckodriver/releases/latest | grep -Eo 'https:.*linux64.tar.gz')
wget $latestFirefox -O geckodriver.tar.gz
tar -xvf geckodriver.tar.gz -C venv/bin/

#Install required packages
source venv/bin/activate
pip install -r requirements.txt

#cleanup
rm geckodriver.tar.gz
rm chromedriver_linux64.zip
