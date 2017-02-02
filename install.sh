#!/bin/bash

sudo chown pi:users -R /var/www/html

sudo mkdir -p /opt/images/
sudo chown pi:users -R /opt/images

sudo ln -s /home/pi/captureCam2Web/www/index.php index.php

