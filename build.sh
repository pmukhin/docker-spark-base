#!/bin/bash

set -e

TAG=2.4.1-hadoop2.7.x

build() {
    NAME=$1
    IMAGE=mukhin/spark-$NAME:$TAG
    cd $([ -z "$2" ] && echo "./$NAME" || echo "$2")
    echo '--------------------------' building $IMAGE in $(pwd)
    docker build -t $IMAGE .
    cd -
}

push() {
    NAME=$1
    IMAGE=mukhin/spark-$NAME:$TAG

    echo '-------------------------' pushing $IMAGE in $(pwd)
    docker push $IMAGE
}

build base
build master
build worker

# push base
# push master
# push worker
