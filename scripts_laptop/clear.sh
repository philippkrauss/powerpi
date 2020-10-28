#!/bin/sh

if nc -w1 -z 172.20.10.9 22 2 2>/dev/null; then
  PI=172.20.10.9
else
  PI=192.168.2.103
fi

ssh pi@$PI 'rm /home/pi/fotos/*'
