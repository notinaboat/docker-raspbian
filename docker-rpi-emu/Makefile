NAME=docker-rpi-emu
VERSION:=1.0
TMP:=$(NAME)-$(shell echo $$RANDOM)

all: build

build:
	docker build --progress plain --tag $(NAME):$(VERSION) .

run:
	docker run --name $(TMP) --rm -it $(NAME):$(VERSION)
