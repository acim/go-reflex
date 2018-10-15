#!/usr/bin/env bash

cd /app && go build -ldflags='-s -w' -race -o /go/bin/app
/go/bin/app