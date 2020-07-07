#!/bin/sh

. ./setenv.sh

NETWORK=" "

if [ "$1" = "host" ]
then
    NETWORK="--network host"
fi

docker run \
    -it \
    --rm \
    --name debug \
    $NETWORK \
    $IMAGE bash

