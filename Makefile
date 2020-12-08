NAME=rasbian-lite
VERSION:=1.0
TMP:=$(NAME)-$(shell echo $$RANDOM)

all: build extract julia

build:
	make -C docker-rpi-emu
	docker build --progress plain --tag $(NAME):$(VERSION) .

extract:
	docker run --name $(TMP) $(NAME):$(VERSION) \
        qemu-img convert -O raw rpi.qcow2 raspbian.img
	docker cp $(TMP):/root/raspbian.img .
	docker rm $(TMP)

run:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)

emu:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION) bash qemu.sh

julia:
	docker run -it --rm --privileged=true \
               -v $(PWD):/usr/rpi/images \
               -w /usr/rpi \
               docker-rpi-emu:1.0 \
               /bin/bash -c './run.sh images/raspbian.img  \
                                      /mnt/shared/julia_precompile.sh'

emu2:
	docker run -it --rm --privileged=true \
               -v $(PWD)/../../:/usr/rpi/images \
               -w /usr/rpi \
               docker-rpi-emu:1.0 \
               /bin/bash -c './run.sh images/jlpi/docker-raspbian/raspbian.img /bin/bash'

emu2env:
	docker run -it --rm --privileged=true \
               -v $(PWD)/../../:/usr/rpi/images \
               -w /usr/rpi \
               docker-rpi-emu:1.0 \
               /bin/bash

jlcross:
	docker run -it --rm \
	             terasakisatoshi/jlcross:rpizero-v1.5.2 \
               /bin/bash
