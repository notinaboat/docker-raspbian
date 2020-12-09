#!/bin/bash
set -x
qemu-system-arm                                                                \
    -machine vexpress-a15                                                      \
    -cpu     max                                                               \
    -smp     2                                                                 \
    -m       2G                                                                \
    -kernel  kernel.img                                                        \
    -dtb     vexpress.dtb                                                      \
    -sd      ../../raspbian.img                                                \
    -append  "root=/dev/mmcblk0p2 rw console=ttyAMA0,15200 loglevel=8"         \
    -nic     hostfwd=tcp::5555-:22                                             \
    -nographic                                                                 \
    -no-reboot
