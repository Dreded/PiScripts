#!/bin/bash
#not neccesarily a script yet
apt-get update
apt-get install ffmpeg v4l-utils
apt-get install libmariadbclient18 libpq5
wget https://github.com/Motion-Project/motion/releases/download/release-4.1/pi_stretch_motion_4.1-1_armhf.deb
dpkg -i pi_stretch_motion_4.1-1_armhf.deb
apt-get install python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev
pip install motioneye
mkdir -p /etc/motioneye
cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf
mkdir -p /var/lib/motioneye
cp /usr/local/share/motioneye/extra/motioneye.systemd-unit-local /etc/systemd/system/motioneye.service
systemctl daemon-reload
systemctl enable motioneye
systemctl start motioneye

#to upgrade run
#pip install motioneye --upgrade
#systemctl restart motioneye
