# powerpi
a raspberry pi project to capture readings from a power meter

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

### poor lighting



### OCR
