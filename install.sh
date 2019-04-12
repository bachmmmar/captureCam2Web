#!/bin/bash

source scripts/checkSuccess.sh

# install tools
sudo apt-get install gphoto2 apache2 php libapache2-mod-php imagemagick
checkSuccess $? "installing packages"

# change rights to access gpio and install python lib
sudo usermod -a -G gpio pi
#sudo usermod -a -G gpio www-data
#sudo usermod -a -G plugdev www-data
#sudo chown root:gpio /dev/mem
#sudo chmod g+wr /dev/mem
sudo apt-get install python3-rpi.gpio
checkSuccess $? "install python gpio"

sudo a2enmod cgi
checkSuccess $? "enable python cgi for apache"


sudo chown www-data:users -R /var/www/html
sudo mkdir /var/www/html/img
sudo chmod g+s /var/www/html/img

sudo mkdir -p /opt/images/
sudo chown pi:users -R /opt/images
sudo chmod g+s /opt/images

sudo rm /var/www/html/index.html
sudo ln -s $(pwd)/www/index.html /var/www/html/index.html
sudo ln -s $(pwd)/www/latest_pictures.php /var/www/html/latest_pictures.php
sudo ln -s $(pwd)/www/filecontrol.py /var/www/html/filecontrol.py


# Install start scripts
SYSTEMD_SCRIPT_DIR=/etc/systemd/system/
sudo cp captureCam2Web.service $SYSTEMD_SCRIPT_DIR
checkSuccess $? "copy start script"

sudo sed -i "s+%PATH_TO_SCRIPT%+$(pwd)+" ${SYSTEMD_SCRIPT_DIR}captureCam2Web.service
checkSuccess $? "Replace Path for Capture cam"

sudo systemctl daemon-reload
checkSuccess $? "reload script deamon"

sudo systemctl disable captureCam2Web.service
checkSuccess $? "Enable Capture cam"
