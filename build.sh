#!/usr/bin/env bash

TAG="neilotoole/goreleaser-xcgo:latest"

GORELEASER_VERSION=0.127.0
#bf7e0f34d1d46041f302a0dd773a5c70ff7476c147d3a30659a5a11e823bccbd  goreleaser_Linux_x86_64.tar.gz
GORELEASER_SHA=bf7e0f34d1d46041f302a0dd773a5c70ff7476c147d3a30659a5a11e823bccbd

docker build -t "${TAG}" .
