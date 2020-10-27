
# docker-raspbian

(Based on https://github.com/hannseman/docker-raspbian)

This Dockerfile builds a headless Raspbian Buster Lite image for Pi Zero W with:
 * USB OTG Ethernet Interface
 * WiFI
 * OpenSSH Server
 * Read-only filesystems

## Usage

Edit `rc.local` to configure `ssid=` and `psk=` for your WiFi network

Type `make` to build the image.

Copy the image to an SD card: `dd bs=1m if=raspbian.img of=/dev/diskN`

Use `id_pi.pem` to connect by ssh: `ssh -i id_pi.pem pi@raspberrypi.local`
