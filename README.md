# powerpi
a raspberry pi project to capture readings from a power meter

## BOM

Since I did not have time to wait 6 weeks for delivery from China, I sourced the parts from german suppliers.
I assume that the price of at least some of the components would have been much cheaper if I had ordered at aliexpress...

* Raspberry Pi 3, Model B, 1 GB RAM (34 €)
* Raspberry Pi power supply 5V 2.5A (7 €)
* Raspberry Pi Camera RPI JT CAM 5MP from Joy-IT (10,64 €)
* Raspberry Pi case (5,34 €)
* Micro SD 16 GB (7,70 €) - I ordered this one but actuall received a 32GB SD card...
* AZDelivery 5V RGB LED Ring WS2812B 12-Bit 50mm Arduino (3 pieces, together for 7,99€)
* DeLock cable USB > DC 5,5 x 2,1 mm (2,80 €)

## location

The location of the power meter has access to electric power, but no other infrastructure is available (especially no WLAN).
It is also not located inside my house, but inside a locked room in a public building (the local church).
The room has small window to the north, so it is very poorly lit.

The powerpi is equipped with a camera module.
The power meter itself is located inside a fuse box that has a transparent door.
So I glued the powerpi to the outside of the fuse box, with the camera located about 10 centimeters away from the meter.

The idea is that the powerpi takes fotos in regular intervals.
Since there is no stationary WLAN available, I will regularly drive by and collect the readings by opening a WLAN from my cell phone.

* In its first stage, the powerpi will just take fotos regularly. I will collect the fotos and extract the readings manually
* In the second stage, it could extract the readings automatically using OCR.

## Technical issues

There are a number of issues to be solved:

### Collection of readings without stationary WLAN

I configured the powerpi to automatically connect to my IPhone's WLAN access point as soon as I opened it.
To do this, I added the following lines to `/etc/wpa_supplicant/wpa_supplicant.conf`:
```
network={
	ssid="iPhone von Philipp"
	psk="<zip>"
	key_mgmt=WPA-PSK
}
```
Unfortunately, this only works when a screen is connected via HDMI.
Not sure why.
I discovered that execution of a WLAN scan after reboot fixed the issue:
```
sudo iwlist wlan0 scan
```
My testing showed that it is enough to execute the command once after reboot, but I wanted to make sure that it still works if I return to the powerpi after several weeks.
Therefore I scheduled the scan to be executed every 10 minutes using crontab.

In addition, I edited `/etc/network/interfaces` and added the following lines:
```
interface wlan0
request 172.20.10.9
```
This should make sure the powerpi always has the same IP address.

My on site testing showed that I am able to access the powerpi without actually entering the locked room.
In fact, I don't even need to enter the building itself.
I can open my access point outside and collect the readings from there.

See the folder `/scripts_laptop` for the scripts I use on my laptop to access the powerpi.
I added my public key to the `~/.ssh/authorized_keys` file so that I don't have to type my password every time.

### regularly taking a foto

This one is easy.
The command to take a foto is `raspistill`.
The camera needs to be enabled using `raspi-config` first, but after that, no surprises at all.

I created a script located in `/scripts_powerpi` to take the foto and scheduled it to run at the top of every hour using crontab.
For the beginning, the cron expression is `0 9,10,11,12,13,14,15,16 * * *`.
Since I am relying on dailight, it makes no sense to take fotos at night.

Foto size is about 200k at a resolution of 640*480, which seems like a reasonable size when buffering it for 2-3 weeks.

### poor lighting

Since the powerpi is relying on daylight coming through a north-facing window, I do not expect to get too many good fotos at all.
In fact I am not yet sure that I will get any at all.
Therefore, I bought an LED ring with 12 LEDs which I plan to add around the camera.

It should be possible to use GPIO to switch the LED ring on right before taking the foto and switch it off again afterwards.
I found a blog describing how to do it: http://frederickvandenbosch.be/?p=1014

### OCR

I haven't started looking into this yet, but my Colleague Andrey already has a very similar solution in place using opencv-python.
He gave me access to his code, so as soon as I have the rest of the solution in place, I will start looking into this.
