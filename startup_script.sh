#!/bin/bash

echo "Install Rubby"

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo "Check Ruby & Bundler"
ruby -v
bundler -v

echo "Install MongoDB"

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

echo "Check MongoDB"
sudo systemctl status mongod

echo "Install Git"
sudo apt-get install -y git

echo "Deploy Reddit"
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d

ps aux | grep puma
