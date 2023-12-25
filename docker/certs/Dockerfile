FROM golang

RUN go install github.com/jsha/minica@latest \
    && mkdir -p /certs

WORKDIR /certs