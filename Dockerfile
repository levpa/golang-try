FROM golang:1.24.5-alpine AS builder

LABEL maintainer="lev.pa@levarc.com"
LABEL org.opencontainers.image.source="https://github.com/levpa/golang-try"

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

RUN apk add --no-cache git make curl date
RUN go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.5.0

COPY . .
RUN make check
RUN make build

FROM scratch
COPY --from=builder /app/main .
EXPOSE 9000
CMD ["./main"]
