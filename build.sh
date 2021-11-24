#!/usr/bin/env bash

if [ -n ${APT_INSTALL} ]; then
    apt-get update && apt-get install -y "${APT_INSTALL}" && rm -rf /var/lib/apt/lists/*
fi

args=(-o /go/bin/app)

if [[ ${RACE_DETECTOR} -eq "1" ]]; then
	CGO_ENABLED=1
    args+=(-race)
fi

cd /app
go build "${args[@]}" ${BUILD_ARGS}
/go/bin/app ${RUN_ARGS}
