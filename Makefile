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