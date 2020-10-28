#!/bin/bash

if [ "$1" == "" ]
then
    INIT=""
else
    INIT="mount -t proc proc /proc;"
    INIT+="mount -t sysfs sys /sys;"
    INIT+="mount -t vfat /dev/sdb1 /mnt;"
    INIT+="source /mnt/$1"
    INIT="init=/bin/bash -c \"$INIT\""
fi

set -x

qemu-system-arm -cpu arm1176 -m 256                                            \
                -machine versatilepb                                           \
                -dtb     rpi.dtb                                               \
                -kernel  rpi.kernel                                            \
                -append  "root=/dev/sda2 rootfstype=ext4 $INIT"                \
                -drive   index=0,media=disk,file=rpi.qcow2                     \
                -drive   read-only=on,format=raw,index=1,media=disk,file=fat:/root/shared   \
                -nographic                                                     \
                -no-reboot
