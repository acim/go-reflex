ARG GO_VERSION
FROM golang:${GO_VERSION}

LABEL org.label-schema.description="Docker image for auto-recompiling and auto-restarting Golang server" \
    org.label-schema.name="acim/go-reflex" \
    org.label-schema.url="https://github.com/acim/go-reflex/blob/master/README.md" \
    org.label-schema.vendor="ablab.de"

RUN go get -u github.com/cespare/reflex

COPY reflex.conf /usr/local/etc/
COPY build.sh /usr/local/bin/

WORKDIR /app

CMD ["reflex", "-d", "none", "-c", "/usr/local/etc/reflex.conf"]

EXPOSE 3000