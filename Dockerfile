FROM golang:1.23.3

RUN go install github.com/cespare/reflex@latest

COPY reflex.conf /usr/local/etc/
COPY build.sh /usr/local/bin/

WORKDIR /app

VOLUME /go

CMD ["reflex", "-d", "none", "-c", "/usr/local/etc/reflex.conf"]
