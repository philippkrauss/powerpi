#!/bin/sh

raspistill -w 640 -h 480 -n -t 2500 -ts -o ./fotos/image%d.jpg
