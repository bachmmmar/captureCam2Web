# Capture images from Canon PowerShot SX110 IS

This code captures images from Canon PowerShot camera and provides the images on a webpage and add them to an archive

For this purpose the Camera needs:
 - to be connected to Raspberry Pi with an USB cable
 - should be powered with an external powersupply
 - the powerbutton needs to be controllable by the Raspberry Pi


## Camera modification
To be able to poweron/poweroff the camera needs to be modified.
 * First the camera needs to be disasembled (remove back and front enclosure)
 * Solder two wires to the Powerbutton connector in the front enclosure. (use coated copper wire)
 * guide the cables through the battery box out of the camera and add some hot melt binding.
 * reassemble the camera
 * connect an optocopler to the two wire. Ensure correct polarization of the bipolar transistor within the optocopler. Measure the voltage on both wire refered to the camera supply votage. The lower cable must be connected to the emitter.
 * connect photodiode with a ~150Ohm resistor to a gpio pin of the raspberry (i'm using GPIO 24 (PIN18))


## Software configuration

