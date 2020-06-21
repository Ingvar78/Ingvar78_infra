#!/bin/bash

echo "Install Rubby"

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo "Check Ruby & Bundler"
ruby -v
bundler -v
