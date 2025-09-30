FROM mcr.microsoft.com/devcontainers/go:1-1.24-bookworm AS builder
WORKDIR /app

RUN go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.5.0

COPY go.mod go.sum Makefile ./
RUN make verify

COPY . .
RUN make test && make build

FROM gcr.io/distroless/static
COPY --from=builder /app/main /main
EXPOSE 9000
ENTRYPOINT ["/main"]
