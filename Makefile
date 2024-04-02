main = main

.PHONY: build
build: ## build main container
	docker compose build $(main)

.PHONY: run
run: ## run main container
	docker compose run --rm $(main)

.PHONY: test
test: ## run test
	docker compose run --rm $(main) /dotfiles/test.sh

.PHONY: ci
ci: ## run ci, github actions locally
	./bin/act -W .github/workflows/ci.yml

.PHONY: ps
ps: ## show container status
	docker compose ps

.PHONY: bash
bash: ## enter main container
	docker compose run --rm $(main) /bin/bash

.PHONY: log
log: ## log main container
	docker compose logs $(main)

.PHONY: help
help: ## show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
