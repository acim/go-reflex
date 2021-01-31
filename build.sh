#!/usr/bin/env bash

args=(-o /go/bin/app)

if [[ $RACE_DETECTOR -eq 1 ]]; then
	CGO_ENABLED=1
    args+=(-race)
fi

cd /app
go build "${args[@]}" ${BUILD_ARGS}
/go/bin/app ${RUN_ARGS}
