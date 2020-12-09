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

#ramdev=$(hdiutil attach -nomount ram://8000000)


qemu-system-aarch64                                                            \
    -machine virt                                                              \
    -cpu     max                                                               \
    -smp     8                                                                 \
    -m       4G                                                                \
    -bios    QEMU_EFI.fd                                                       \
    -device  virtio-blk-pci,drive=disk0                                        \
    -drive   if=none,index=0,id=disk0,file=debian.qcow2                        \
    -device  e1000,netdev=net0                                                 \
    -netdev  user,id=net0,hostfwd=tcp:127.0.0.1:5555-:22                       \
    -nographic                                                                 \
    -no-reboot
