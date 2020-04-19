#!/usr/bin/env bash

source setenv.sh

echo "Criando imagem $DOCKER_REGISTRY/golang-$GOLANG_VERSION"
docker build -t $DOCKER_REGISTRY/golang-$GOLANG_VERSION .
