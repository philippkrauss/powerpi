#!/bin/sh

# enable flash LED ring
pigs modes 17 w
pigs w 17 0
sleep 1
# take foto
raspistill -w 640 -h 480 -n -t 2500 -ts -o /home/pi/fotos/image%d.jpg
# disable flash ring
pigs w 17 1
