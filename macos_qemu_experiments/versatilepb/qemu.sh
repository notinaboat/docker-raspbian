#!/bin/bash
set -x
qemu-system-arm \
    -cpu     arm1176                                                           \
    -m       256                                                               \
    -machine versatilepb                                                       \
    -dtb     versatilepb.dtb                                                   \
    -kernel  kernel.img                                                        \
    -append  "root=PARTUUID=907af7d0-02 $INIT"                                 \
    -drive   if=none,index=0,media=disk,id=disk0,file=../../raspbian.img       \
    -drive   if=none,index=1,media=disk,id=disk1,file=../debian/debian.qcow2\
    -device  virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off   \
    -device  virtio-blk-pci,drive=disk1,disable-modern=on,disable-legacy=off   \
    -nographic                                                                 \
    -no-reboot
