#!/bin/bash

#Install latest stable Chrome browser
sudo yum -y upgrade google-chrome-stable
chromeVersion=$(google-chrome --product-version) &&
chromeMajorVersion=${chromeVersion%%.*} &&
echo "Chrome version: "$chromeMajorVersion &&
#Install the latest matching Chrome driver
latestDriverURL=https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$chromeMajorVersion &&
latestDriverFileName="LATEST_RELEASE_"$chromeMajorVersion &&
wget $latestDriverURL &&
latestFullDriverVersion=$(cat $latestDriverFileName) &&
finalURL="https://chromedriver.storage.googleapis.com/"$latestFullDriverVersion"/chromedriver_linux64.zip" &&
echo $finalURL
rm -rf /tmp/chromedriver/
mkdir /tmp/chromedriver/ &&
wget -O /tmp/chromedriver/chromedriver.zip $finalURL &&
sudo unzip -o /tmp/chromedriver/chromedriver.zip chromedriver -d /usr/local/bin/
chromedriverVersion=$(chromedriver --version) &&
chromedriverMajorVersion=${chromedriverVersion%%.*} &&
echo "Chrome driver version: "$chromedriverMajorVersion
