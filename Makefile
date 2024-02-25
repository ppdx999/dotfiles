.PHONY: build
build:
	docker compose build --no-cache

.PHONY: run
run:
	docker compose run --rm main

.PHONY: test
test:
	docker compose run --rm main /dotfiles/test.sh

.PHONY: ci
ci:
	./bin/act -W .github/workflows/ci.yml
