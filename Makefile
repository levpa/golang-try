.PHONY: test verify build image precommit

precommit:
	bash ./scripts/install-precommit-hook.sh

verify:
	go mod tidy && go mod download && go mod verify

test:
	golangci-lint run --verbose ./... && go test ./...

check-build:
	go build -trimpath -o /dev/null ./...

VERSION ?= $(shell git tag --sort=-v:refname | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$$' | head -n 1)
COMMIT := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

build:
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -trimpath \
		-ldflags "-X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(BUILD_DATE)" \
		-o main .

image:
	docker build \
		--label org.opencontainers.image.version="$(VERSION)" \
		--label org.opencontainers.image.revision="$(COMMIT)" \
		--label org.opencontainers.image.created="$(BUILD_DATE)" \
		--label org.opencontainers.image.source="https://github.com/levpa/golang-try" \
		-t levarc/golang-try:$(VERSION) .

BUMP ?= patch

release:
	@echo "🚀 Releasing version bump..."
	bash scripts/bump-version.sh $(BUMP)
