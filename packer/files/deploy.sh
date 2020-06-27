#!/bin/bash

set -e

echo "Install Git"
sudo apt-get install -y git apt-transport-https

echo "Install Reddit"
APPUSER="appuser"
useradd -U -d /home/$APPUSER -s /bin/bash $APPUSER
sudo git clone -b monolith https://github.com/express42/reddit.git /home/$APPUSER/reddit
chown -R $APPUSER:$APPUSER /home/$APPUSER
cd /home/$APPUSER/reddit && bundle install

echo "[Unit]
Description=Puma HTTP Server
After=network.target
Requires=mongod.service

[Service]
Type=simple
User=$APPUSER
Group=$APPUSER
WorkingDirectory=/home/$APPUSER/reddit
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/puma.service

systemctl enable puma.service
systemctl start puma.service
