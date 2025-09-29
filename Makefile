.PHONY: lint test tidy verify check

lint:
	golangci-lint run --verbose

test:
	go test ./...

tidy:
	go mod tidy

verify:
	go mod verify

check: lint test tidy verify

VERSION := $(shell git describe --tags --always)
COMMIT := $(shell git rev-parse HEAD)
BUILD_DATE := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

build:
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -trimpath \
		-ldflags "-X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(BUILD_DATE)" \
		-o main .
