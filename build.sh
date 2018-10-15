#!/usr/bin/env bash

args = (
	-o /go/bin/app
)

if [[ -v STRIP_BINARY ]]; then
    args+=(-ldflags='-s -w')
fi

if [[ -v RACE_DETECTOR ]]; then
	export CGO_ENABLED=1
    args+=(-race)
fi

cd /app
go build "${args[@]}"
/go/bin/app