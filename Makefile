NAME=rasbian-lite
VERSION:=1.0
TMP:=$(NAME)-$(shell echo $$RANDOM)

all: build extract

build:
	docker build --progress plain --tag $(NAME):$(VERSION) .

extract:
	docker create --name $(TMP) $(NAME):$(VERSION)
	docker cp $(TMP):/root/raspbian.img .
	docker rm $(TMP)

run:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)

emu:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION) bash qemu.sh
