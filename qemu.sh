#!/bin/bash

qemu-system-arm -cpu arm1176                                                   \
                -m 256                                                         \
                -machine versatilepb                                           \
                -dtb versatile-pb.dtb                                          \
                -kernel kernel-qemu-buster                                     \
                -append "root=/dev/sda2 rootfstype=ext4"                       \
                -drive format=raw,index=0,media=disk,file=raspbian.img         \
                -nographic                                                     \
                -no-reboot
