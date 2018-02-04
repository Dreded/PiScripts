#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install samba samba-common-bin
sudo nano /etc/samba/smb.conf

sudo smbpasswd -a pi
sudo service smbd restart
