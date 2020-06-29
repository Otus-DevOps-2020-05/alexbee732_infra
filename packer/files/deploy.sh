#!/bin/bash
sudo apt install -y git apt-transport-https
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
cd /etc/systemd/
# Добавляем запуск сервера в systemd
echo '[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=forking
User=appuser
Group=appuser
ExecStart=/usr/local/bin/puma --dir /home/ubuntu/reddit -d
Restart=always

[Install]
WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable puma.service
