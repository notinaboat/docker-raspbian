#!/bin/sh
raspi-config --expand-rootfs nonint
rm /etc/rc.local
systemctl reboot
exit 0
