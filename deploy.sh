#!/bin/bash

echo "Install Git"
sudo apt-get install -y git apt-transport-https

echo "Install Reddit"

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d

echo "Get port "
ps aux | grep puma
