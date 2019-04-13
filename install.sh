#!/bin/bash

source scripts/checkSuccess.sh

# install tools
sudo apt-get install gphoto2 apache2 php libapache2-mod-php imagemagick
checkSuccess $? "installing packages"

# setup gpio to start camera
sudo usermod -a -G gpio pi
checkSuccess $? "change rights to access gpio"

sudo apt-get install python3-rpi.gpio
checkSuccess $? "install python gpio"

# configure apache to run python scripts
sudo a2enmod cgi
checkSuccess $? "enable python cgi for apache"

sudo cp enable_python_execution.conf /etc/apache2/sites-enabled/
checkSuccess $? "adding apache config to enable python execution"

echo "edit \"sudo emacs /lib/systemd/system/apache2.service\" and remove PrivateTmp=true"
echo "press any key to continue...."
read -n1 ans

# setup www directory
sudo chown www-data:users -R /var/www/html
sudo mkdir /var/www/html/img
sudo chmod 775 /var/www/html/img
sudo chmod g+s /var/www/html/img


sudo rm /var/www/html/index.html
sudo ln -s $(pwd)/www/index.html /var/www/html/index.html
sudo ln -s $(pwd)/www/latest_pictures.php /var/www/html/latest_pictures.php
sudo ln -s $(pwd)/www/filecontrol.py /var/www/html/filecontrol.py

# prepare folder for images from camera
sudo mkdir -p /opt/images/
sudo chown pi:users -R /opt/images
sudo chmod g+s /opt/images


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
