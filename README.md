# Docker image for auto-recompiling and auto-restarting Golang server application

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/acim/go-reflex/Docker?logo=github)](https://github.com/acim/go-reflex/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/acim/go-reflex?logo=docker&label=pulls)](https://hub.docker.com/r/acim/go-reflex)
[![Docker Stars](https://img.shields.io/docker/stars/acim/go-reflex?logo=docker&label=stars)](https://hub.docker.com/r/acim/go-reflex)
![Docker Architecture](https://img.shields.io/badge/arch-amd64-blue?logo=docker)
![Docker Architecture](https://img.shields.io/badge/arch-arm64-blue?logo=docker)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/acim/go-reflex?logo=docker)

## Features

- works with [docker-compose](https://github.com/docker/compose) and [kind](https://github.com/kubernetes-sigs/kind)
- uses [cespare/reflex](https://github.com/cespare/reflex) to watch .go and .html files changes and recompile/restart your server application
- optionally compiles with data race detector
- supports amd64 and arm64 architectures

## Feature requests

- please open a [new issue](https://github.com/acim/go-reflex/issues/new)

## How to use with docker-compose

Place docker-compose.yml in your project root and run `docker-compose up --build`.

### docker-compose.yml example with main package in the root of the project

```yaml
version: '3.8'

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

### docker-compose.yml example with main package not in the root of the project

```yaml
version: '3.8'

services:
  myservice:
    image: acim/go-reflex
    environment:
      - RACE_DETECTOR=1
      - BUILD_ARGS=./cmd/server/server.go
    volumes:
      - .:/app
    ports:
      - 3000:3000
```

### docker-compose.yml example with installation of external dependencies

```yaml
version: '3.8'

services:
  myservice:
    image: acim/go-reflex
    environment:
      - RACE_DETECTOR=1
      - APT_INSTALL=libraw-dev
    volumes:
      - .:/app
    ports:
      - 3000:3000
```

## How to use with kind (Kubernetes)

### Install kind

```sh
go install sigs.k8s.io/kind@latest
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
- RUN_ARGS - used to add subcommands and/or flags in the call of your binary (i.e. serve --verbose)
- BUILD_ARGS - used to add flags to go build command (i.e. "./cmd/myapp/main.go")
- APT_INSTALL - used to install additional packages (experimental and not efficient)
