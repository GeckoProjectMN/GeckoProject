#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-geckocoin/geckocoind-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/geckocoind docker/bin/
cp $BUILD_DIR/src/geckocoin-cli docker/bin/
cp $BUILD_DIR/src/geckocoin-tx docker/bin/
strip docker/bin/geckocoind
strip docker/bin/geckocoin-cli
strip docker/bin/geckocoin-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
