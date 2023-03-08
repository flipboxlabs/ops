.PHONY: build push

VERSION := 1.0

build:
	docker build . -t flipbox/ops

push:
	./push --profile flipbox flipbox/ops:${VERSION}

