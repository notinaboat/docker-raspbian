set -x
set -e

# Rasbian SD Card Image.
IMAGE_URL=\
https://downloads.raspberrypi.org\
/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24\
/2020-08-20-raspios-buster-armhf-lite.zip

KERNEL_URL=\
https://raw.githubusercontent.com/\
dhruvvyas90/qemu-rpi-kernel/master/kernel-qemu-5.4.51-buster

DTB_URL=\
https://raw.githubusercontent.com/\
dhruvvyas90/qemu-rpi-kernel/master/versatile-pb-buster-5.4.51.dtb


# Download image, kernel and DTB
curl $KERNEL_URL > kernel.img
curl $DTB_URL > versatilepb.dtb

#curl $IMAGE_URL | funzip > rpi.img
#qemu-img convert -f raw -O qcow2 rpi.img rpi.qcow2
#qemu-img resize rpi.qcow2 4G
