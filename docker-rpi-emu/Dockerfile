FROM ryankurte/docker-rpi-emu

RUN echo 'mount --bind /usr/rpi/images $2/home/sam/git' >> mount.sh
RUN echo 'umount $1/home/sam/git' >> qemu-cleanup.sh
