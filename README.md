# Docker image for auto-recompiling and auto-restarting Golang server application

[![GitHub](https://img.shields.io/github/license/acim/go-reflex)](LICENSE)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/acim/go-reflex/Docker)
![Docker](https://github.com/acim/go-reflex/workflows/Docker/badge.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/acim/go-reflex)](https://hub.docker.com/r/acim/go-reflex)
[![Docker Stars](https://img.shields.io/docker/stars/acim/go-reflex)](https://hub.docker.com/r/acim/go-reflex)
[![HitCount](http://hits.dwyl.com/acim/go-reflex.svg)](http://hits.dwyl.com/acim/go-reflex)

## Features

- works with [docker-compose](https://github.com/docker/compose) and [kind](https://github.com/kubernetes-sigs/kind)
- uses [cespare/reflex](https://github.com/cespare/reflex) to watch .go and .html files changes and recompile/restart your server application
- optionally compiles with data race detector

## Feature requests

- please open a [new issue](https://github.com/acim/go-reflex/issues/new)

## Requirements

- main package is expected to be in the root directory of your project

## How to use with docker-compose

Place docker-compose.yml in your project root and run `docker-compose up --build`.

### docker-compose.yml example

```yaml
version: '3.7'

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

Note: Replace port number with correct port number of your application.

## How to use with kind (Kubernetes)

### Install kind

```sh
GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1
```

### Create local cluster

```sh
kind create cluster --config=config.yaml
```

### config.yaml example

```yaml
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /path/to/your/project/root
        containerPath: /app
```

### Deploy your application

```sh
kubectl apply -f deploy.yaml
```

### deploy.yaml example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: your-app-name
  namespace: default
spec:
  containers:
    - image: acim/go-reflex
      name: your-app-name
      env:
        - name: RACE_DETECTOR
          value: '1'
      volumeMounts:
        - mountPath: /app
          name: app
  restartPolicy: Never
  volumes:
    - hostPath:
        path: /app
      name: app
```

### Start port-forwarding

```sh
kubectl port-forward your-app-name 3000:3000
```

Note: Replace port number with correct port number of your application.

## Optional environment variables

- RACE_DETECTOR=1 - used to turn on data race detector to the compiled binary
- RUN_ARGS - used to add commands and flags in the call of your binary
- BUILD_ARGS - used to add flags to go build command (i.e. "./cmd/myapp/main.go")
