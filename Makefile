NAME=rasbian-lite
VERSION:=1.0
TMP:=$(NAME)-$(shell echo $$RANDOM)

all: build extract

build:
	docker build --progress plain --tag $(NAME):$(VERSION) .

extract:
	docker run --name $(TMP) $(NAME):$(VERSION) \
        qemu-img convert -O raw rpi.qcow2 raspbian.img
	docker cp $(TMP):/root/raspbian.img .
	docker rm $(TMP)

run:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)

emu:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION) bash qemu.sh init1

