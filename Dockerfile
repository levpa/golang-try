FROM mcr.microsoft.com/devcontainers/go:1-1.24-bookworm AS builder
WORKDIR /app

COPY go.mod go.sum Makefile ./
RUN make verify

COPY . .
RUN make build

FROM gcr.io/distroless/static
COPY --from=builder /app/main /main
EXPOSE 9000
ENTRYPOINT ["/main"]
