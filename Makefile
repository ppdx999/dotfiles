.PHONY: install
install:
	echo install start

.PHONY: build
build:
	docker compose build --no-cache

.PHONY: run
run:
	docker compose run --rm main
