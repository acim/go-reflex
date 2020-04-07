# Docker image for auto-recompiling and auto-restarting Golang server

[![GitHub](https://img.shields.io/github/license/acim/go-reflex)](LICENSE)
![Docker](https://github.com/acim/go-reflex/workflows/Docker/badge.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/acim/go-reflex)](https://hub.docker.com/r/acim/go-reflex)
[![Docker Stars](https://img.shields.io/docker/stars/acim/go-reflex)](https://hub.docker.com/r/acim/go-reflex)

## Features

* uses Go modules (Go version >=1.11)
* uses [cespare/reflex](https://github.com/cespare/reflex) to watch .go files changes and recompile/restart your server application
* optionally compiles binary with data race detector

## Feature requests

* please open a [new issue](https://github.com/acim/go-reflex/issues/new)

## Requirements

* your server application is expected to run on port 3000 inside the container, but you can actually use any port

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

## Note for contributors - tagging reminder

* `git tag -a v1.13.8-r0 -m "comment"`
* `git push origin v1.13.8-r0`

Part 1.13.8 from the example above will be used for Golang base image tag.
