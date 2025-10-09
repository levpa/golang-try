.PHONY: test verify lint build check-build image_build image_push precommit release chlog-write

precommit:
	bash ./scripts/install-precommit-hook.sh

verify:
	go mod tidy && go mod download && go mod verify

lint:
	golangci-lint run --verbose ./...

test:
	go test ./...

check-build:
	go build -trimpath -o /dev/null ./...

VERSION ?= $(shell git tag --sort=-v:refname | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$$' | head -n 1)
COMMIT := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

build:
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -trimpath \
		-ldflags "-X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(BUILD_DATE)" \
		-o main .

GHCR := ghcr.io/levpa/golang-try
GHCR_TOKEN ?= undefined

image_build:
	docker buildx build \
		--label "org.opencontainers.image.version=$(VERSION)" \
		--label "org.opencontainers.image.revision=$(COMMIT)" \
		--label "org.opencontainers.image.created=$(BUILD_DATE)" \
		--label "org.opencontainers.image.source=https://github.com/levpa/golang-try" \
		--label "org.opencontainers.image.description=minimalistic GoLang image for backend development" \
		--label "org.opencontainers.image.licenses=MIT" \
		-t $(GHCR):$(VERSION) .

image_push:
	echo "$(GHCR_TOKEN)" | docker login ghcr.io -u levpa --password-stdin
	docker push $(GHCR):$(VERSION)

BUMP ?= patch

release:
	@echo "🚀 Releasing version bump..."
	bash scripts/bump-version.sh $(BUMP)

chlog-write:
	@git log -n 10 --pretty=format:"- %h %s" > CHANGELOG.md
	@git add CHANGELOG.md
	@cat CHANGELOG.md
