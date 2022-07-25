FROM golang:1.18.3 AS builder

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN CGO_ENABLED=0 go build ./cmd/transmission-exporter

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/src/app/transmission-exporter /bin/transmission-exporter

USER 1000

ENTRYPOINT ["/bin/transmission-exporter"]
