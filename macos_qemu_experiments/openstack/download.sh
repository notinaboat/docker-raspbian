set -x
set -e

# https://wiki.debian.org/Arm64Qemu

IMAGE_URL=\
https://cdimage.debian.org\
/cdimage/openstack/current/\
debian-10.6.2-20201124-openstack-arm64.qcow2

EFI_URL=\
http://ftp.au.debian.org\
/debian/pool/main/e/edk2/\
qemu-efi-aarch64_0~20181115.85588389-3+deb10u1_all.deb


# Download System Image
curl -L $IMAGE_URL > debian.qcow2

# Download EFI Firmware
curl $EFI_URL > efi.deb
tar xf efi.deb data.tar.xz
tar -xOzf data.tar.xz ./usr/share/qemu-efi-aarch64/QEMU_EFI.fd > QEMU_EFI.fd

# cp ~/.ssh/id_rsa.pub authorized_keys
# virt-copy-in -a debian.qcow2 authorized_keys /home/debian/.ssh/
