FROM golang:1.25.6

RUN go install github.com/cespare/reflex@v0.3.1

COPY reflex.conf /usr/local/etc/
COPY build.sh /usr/local/bin/

WORKDIR /app

VOLUME /go

CMD ["reflex", "-d", "none", "-c", "/usr/local/etc/reflex.conf"]
