NAME=rasbian-lite
VERSION:=1.0
TMP:=$(NAME)-$(shell echo $$RANDOM)

all: build extract

build:
	docker build --tag $(NAME):$(VERSION) .

extract:
	docker create --name $(TMP) $(NAME):$(VERSION)
	docker cp $(TMP):/root/raspbian.img .
	docker rm $(TMP)

run:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)

emu:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)                       \
    qemu-system-arm -cpu arm1176                                               \
                    -m 256                                                     \
                    -machine versatilepb                                       \
                    -dtb versatile-pb.dtb                                      \
                    -kernel kernel-qemu-buster                                 \
                    -append "root=/dev/sda2 rootfstype=ext4 rw'"               \
                    -drive format=raw,index=0,media=disk,file=raspbian.img     \
                    -nographic                                                 \
                    -no-reboot
