# Docker image for auto-recompiling and auto-restarting Golang server

![GitHub](https://img.shields.io/github/license/acim/go-reflex.svg)
![GitHub tag](https://img.shields.io/github/tag/acim/go-reflex.svg)
[![Docker Automated build](https://img.shields.io/docker/build/acim/go-reflex.svg)](https://hub.docker.com/r/acim/go-reflex/)
[![Docker Build Status](https://img.shields.io/docker/build/acim/go-reflex.svg)](https://hub.docker.com/r/acim/go-reflex/)

## Features

* uses Go modules (Go version >=1.11)
* uses [cespare/reflex](https://github.com/cespare/reflex) to watch .go files changes and recompile/restart your server application
* optionally compiles binary with data race detector

## Requirements

* your server application is expected to run on port 3000 inside the container, but you can actually use any port

## Support on Beerpay

[![Beerpay](https://beerpay.io/acim/go-reflex/badge.svg?style=beer-square)](https://beerpay.io/acim/go-reflex)
[![Beerpay](https://beerpay.io/acim/go-reflex/make-wish.svg?style=flat-square)](https://beerpay.io/acim/go-reflex?focus=wish)

## How to use

Place docker-compose.yml in your project root and run 'docker-compose up --build'.

## docker-compose.yml example

```yaml
version: "3.7"

services:
  myservice:
    image: acim/go-reflex
    environment:
      - RACE_DETECTOR=1
      - RUN_ARGS=server
    volumes:
      - .:/app
    ports:
      - 3000:3000
```

## Optional environment variables

* RACE_DETECTOR=1 - used to turn on data race detector in the compiled binary
* RUN_ARGS - used to add commands and flags in the call of your binary