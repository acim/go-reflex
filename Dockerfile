FROM golang:1

RUN go get github.com/cespare/reflex

COPY reflex.conf /usr/local/etc/
COPY build.sh /usr/local/bin/

CMD ["reflex", "-d", "none", "-c", "/usr/local/etc/reflex.conf"]