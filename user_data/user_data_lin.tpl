#!/bin/bash
mkdir /home/root/www/
cd /home/root/www/
echo '<h1><center>TerraForm is cool with Linux!!!!</center></h1>' > index.html
yum -y install httpd && sudo systemctl start httpd
mv ./index.html /var/www/html/index.html
