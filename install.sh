#!/bin/bash

# install tools
sudo apt-get install git-core tig tmux gphoto2 emacs-nox apache2 php5 libapache2-mod-php5 imagemagick

# change rights to access gpio and install python lib
sudo usermod -a -G gpio pi
sudo apt-get install python3-rpi.gpio

sudo chown pi:users -R /var/www/html

sudo mkdir -p /opt/images/
sudo chown pi:users -R /opt/images

sudo ln -s /home/pi/captureCam2Web/www/index.php index.php

