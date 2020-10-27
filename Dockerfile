FROM debian:buster-slim

ENV RPI_QEMU_KERNEL kernel-qemu-4.19.50-buster
ENV RPI_QEMU_KERNEL_COMMIT 8121f35cd6814ffbde5a18783eb04abb1c0c336a
ENV RASPBIAN_IMAGE 2020-08-20-raspios-buster-armhf-lite
ENV RASPBIAN_IMAGE_URL https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/

WORKDIR /root

# Install dependencies
RUN apt-get update \
&&  apt-get install -y -q \
        busybox \
        curl \
        qemu \
        qemu-system-arm \
        libguestfs-tools \
        unzip \
        linux-image-amd64 \
        netcat \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/

# Download image, kernel and DTB
RUN curl $RASPBIAN_IMAGE_URL/$RASPBIAN_IMAGE.zip > raspbian.zip \
&&  unzip raspbian.zip \
&&  rm raspbian.zip \
&&  mv $RASPBIAN_IMAGE.img raspbian.img \
&&  curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/$RPI_QEMU_KERNEL_COMMIT/$RPI_QEMU_KERNEL > kernel-qemu-buster \
&&  curl -O https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/$RPI_QEMU_KERNEL_COMMIT/versatile-pb.dtb

# Install rc.local
COPY rc.local .
RUN guestfish --rw -m /dev/sda2 -a raspbian.img \
              upload rc.local /etc/rc.local : \
              chmod 0755 /etc/rc.local

# Pad the image to 2G
RUN qemu-img resize -f raw raspbian.img 2G

# Boot the emulator
RUN qemu-system-arm -cpu arm1176                                               \
                    -m 256                                                     \
                    -machine versatilepb                                       \
                    -dtb versatile-pb.dtb                                      \
                    -kernel kernel-qemu-buster                                 \
                    -append "root=/dev/sda2 rootfstype=ext4 rw'"               \
                    -drive format=raw,index=0,media=disk,file=raspbian.img     \
                    -nographic                                                 \
                    -no-reboot
