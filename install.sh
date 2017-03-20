#!/bin/bash

# install tools
sudo apt-get install git-core tig tmux gphoto2 emacs-nox apache2 php5 libapache2-mod-php5 imagemagick

# change rights to access gpio and install python lib
sudo usermod -a -G gpio pi
#sudo usermod -a -G gpio www-data
#sudo usermod -a -G plugdev www-data
#sudo chown root:gpio /dev/mem
#sudo chmod g+wr /dev/mem
sudo apt-get install python3-rpi.gpio

# enable python cgi for apache
sudo a2enmod cgi


sudo chown www-data:users -R /var/www/html
sudo mkdir /var/www/html/img
sudo chmod g+s

sudo mkdir -p /opt/images/
sudo chown pi:users -R /opt/images

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
