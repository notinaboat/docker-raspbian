# Get Julia binaries from jlcross.
FROM terasakisatoshi/jlcross:rpizero-v1.5.2 AS jlcross
WORKDIR /home/pi
RUN tar czf julia.tgz julia-v*


# Start with generic Debian to run QEMU.
FROM debian:buster-slim
WORKDIR /root

# Old QEMU because: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=918950
ENV QEMU_ARM_DEB \
https://snapshot.debian.org\
/archive/debian/20180602T030602Z/pool/main/q/qemu\
/qemu-system-arm_2.12%2Bdfsg-3_amd64.deb


# Install QEMU and misc tools
RUN apt-get update \
&&  apt-get install -y -q \
        busybox \
        curl \
        unzip \
        qemu-utils \
&&  curl -O $QEMU_ARM_DEB \
&&  (dpkg -i qemu-system-arm_*.deb || true) \
&&  apt-get install -f -y \
&&  rm *.deb \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/

# Rasbian SD Card Image.
ENV IMAGE_URL \
https://downloads.raspberrypi.org\
/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24\
/2020-08-20-raspios-buster-armhf-lite.zip

# ARM Kernel for QEMU.
ENV KERNEL_URL \
https://raw.githubusercontent.com\
/dhruvvyas90/qemu-rpi-kernel/8121f35cd6814ffbde5a18783eb04abb1c0c336a\
/kernel-qemu-4.19.50-buster

# DTB for QEMU.
ENV DTB_URL \
https://raw.githubusercontent.com\
/dhruvvyas90/qemu-rpi-kernel/8121f35cd6814ffbde5a18783eb04abb1c0c336a\
/versatile-pb.dtb

# Download image, kernel and DTB
RUN curl $KERNEL_URL > rpi.kernel \
&&  curl $DTB_URL > rpi.dtb \
&&  curl $IMAGE_URL | funzip > rpi.img \
&&  qemu-img convert -f raw -O qcow2 rpi.img rpi.qcow2 \
&&  qemu-img resize rpi.qcow2 4G \
&&  rm rpi.img

# Run the expand rootfs script in the emulator
COPY --from=jlcross /home/pi/julia.tgz shared/
COPY . .

# Run "init1" script in QEMU to resize the root filesystem and install rc.local.
# Then reboot to run rc.local.
RUN bash qemu.sh init1 \
&&  bash qemu.sh
