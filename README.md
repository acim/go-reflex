# Docker image of auto-recompiling Golang server

![GitHub](https://img.shields.io/github/license/acim/go-reflex.svg)
![GitHub tag](https://img.shields.io/github/tag/acim/go-reflex.svg)
[![Docker Automated build](https://img.shields.io/docker/build/acim/go-reflex.svg)](https://hub.docker.com/r/acim/go-reflex/)
[![Docker Build Status](https://img.shields.io/docker/build/acim/go-reflex.svg)](https://hub.docker.com/r/acim/go-reflex/)

## Support on Beerpay

[![Beerpay](https://beerpay.io/acim/go-reflex/badge.svg?style=beer-square)](https://beerpay.io/acim/go-reflex)
[![Beerpay](https://beerpay.io/acim/go-reflex/make-wish.svg?style=flat-square)](https://beerpay.io/acim/go-reflex?focus=wish)

## docker-compose.yml example

```yaml
version: "3.7"

services:
  myservice:
    image: acim/go-reflex
    environment:
      - RACE_DETECTOR=1
    volumes:
      - .:/app
    ports:
      - 3000:3000
```

Your application will be exposed on port 3000 of your localhost and will be recompiled and restarted on each modification of *.go files.

Supported environment variables:

* STRIP_BINARY=1 (optional) is used to strip out debug symbols from binary
* RACE_DETECTOR=1 (optionsl) is used to turn on data race detector in the compiled binary