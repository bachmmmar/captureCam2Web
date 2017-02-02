#!/bin/bash

source scripts/checkSuccess.sh

CAMERA_NAME='Canon PowerShot SX110 IS'
WWW_BASEDIR="/var/www/html/"
ARCHIVE_DIR="/opt/images/"
ZOOM_LEVELS="1 18"

function isCameraRunning() {
    echo $(gphoto2 --auto-detect | grep ${CAMERA_NAME} | wc -l)
}

function createDestinationFolder() {
    mkdir -p ${WWW_BASEDIR}img
    checkSuccess $? "Create image directory"
}

# Parameter 1: zoom level
function copyImageToWWW() {
    mogrify -quality 100 -path /tmp -resize 1280x960 captimg.jpg
    mv /tmp/captimg.jpg ${WWW_BASEDIR}img/img_zoom$1.jpg    
    checkSuccess $? "Create thumbnail image in www directory"
}

function moveImage2Cache() {
    mv captimg.jpg ${ARCHIVE_DIR}$(date +%Y-%m-%dT%H:%M:%S)_zoom$1.jpg
    checkSuccess $? "Move image to archive directory"
}

# Parameter 1: zoom level
function takePicture() {
    echo "take picture.."
    gphoto2 --set-config Zoom=$1
    gphoto2 --capture-image-and-download --force-overwrite --filename=captimg.jpg
    checkSuccess $? "Picture taken"
}

function processSelectedZoomLevels() {
    for ZOOM in $ZOOM_LEVELS; do
	takePicture $ZOOM
	copyImageToWWW $ZOOM
	moveImage2Cache $ZOOM
    done
}

echo "detecting camera..."
checkSuccess $(isCameraRunning) "Camera detected"

createDestinationFolder

processSelectedZoomLevels
