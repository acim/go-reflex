FROM golang:1.17.3

RUN go get -u github.com/cespare/reflex

COPY reflex.conf /usr/local/etc/
COPY build.sh /usr/local/bin/

WORKDIR /app

VOLUME /go

CMD ["reflex", "-d", "none", "-c", "/usr/local/etc/reflex.conf"]

EXPOSE 3000
