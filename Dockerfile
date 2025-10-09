FROM mcr.microsoft.com/devcontainers/go:1.25-bookworm AS builder
WORKDIR /app

COPY . .
RUN go mod tidy && go mod download && go mod verify
RUN make build

FROM gcr.io/distroless/static
COPY --from=builder /app/main /main
EXPOSE 9000
ENTRYPOINT ["/main"]
