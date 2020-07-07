#!/bin/sh

. ./setenv.sh

docker build -t $IMAGE .

if [ "$1" = "push" ]
then
    docker push $IMAGE
fi
