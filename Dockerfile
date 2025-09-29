LABEL maintainer="lev.pa@levarc.com"
LABEL org.opencontainers.image.source="https://github.com/levpa/golang-try"

FROM golang:1.24.5-alpine as builder

ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

RUN apk add --no-cache git make curl date
COPY . .
RUN make check && make build

FROM scratch
COPY --from=builder /app/main .
EXPOSE 9000
CMD ["./main"]
