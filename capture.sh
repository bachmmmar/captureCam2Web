#!/bin/bash

CAMERA_NAME="Canon PowerShot SX110 IS"


function isCameraRunning() {
    echo $(gphoto2 --auto-detect | grep ${CAMERA_NAME} | wc -l)
}



gphoto2 --set-config Zoom=1
