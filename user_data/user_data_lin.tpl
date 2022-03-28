#!/bin/bash
mkdir /home/root/www/
cd /home/root/www/
wget https://github.com/livernyc/ec2-userdata-terraform/tree/main/user_data/default_linux.html
yum -y install httpd && sudo systemctl start httpd
mv ./default_linux.html /var/www/html/index.html
echo "Changing Hostname"
#hname="$ServerName"
echo "$ServerName" > /etc/hostname
