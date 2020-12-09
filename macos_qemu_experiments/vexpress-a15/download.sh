set -x
set -e

# https://sven.stormbind.net/blog/posts/deb_qemu_rpi2_2020/

KERNEL_URL=\
https://github.com\
/vfdev-5/qemu-rpi2-vexpress/raw/master/kernel-qemu-4.4.1-vexpress

DTB_URL=\
https://github.com\
/vfdev-5/qemu-rpi2-vexpress/raw/master/vexpress-v2p-ca15-tc1.dtb

# Download kernel and dtb.
curl -L $KERNEL_URL > kernel.img
curl -L $DTB_URL > vexpress.dtb
