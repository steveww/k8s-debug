#!/bin/bash

IMAGE="steveww/debug"
NAMESPACE="default"

usage() {
    echo " "
    echo "debug.sh [-n namespace] <start|conn|del>"
    echo " "
    exit 1
}

while getopts 'n:' c
do
    case $c in
        n)
            NAMESPACE=$OPTARG
            ;;
    esac
done
shift $((OPTIND - 1))

echo "Using namespace $NAMESPACE"
case "$1" in
    start)
        kubectl -n $NAMESPACE get deployment debug >/dev/null 2>&1
        RET=$?
        if [ $RET -eq 0 ]
        then
            echo "Deployment debug already exists in $NAMESPACE"
        else
            kubectl -n $NAMESPACE create deployment debug --image=$IMAGE
            kubectl -n $NAMESPACE create service clusterip debug --tcp=8080:8080
        fi
        ;;
    conn)
        POD=$(kubectl -n $NAMESPACE get pod | egrep '^debug-' | awk '{ print $1 }' -)
        if [ -n "$POD" ]
        then
            kubectl -n $NAMESPACE exec -it $POD -- bash
        else
            echo "Did not find debug pod, did you remember to start it?"
        fi
        ;;
    del)
        echo -n "Are you sure you want to delete deployment debug from $NAMESPACE <y/n>? "
        read ANS
        if [ "$ANS" = "y" ]
        then
            kubectl -n $NAMESPACE delete deployment debug
            kubectl -n $NAMESPACE delete service debug
        fi
        ;;
    *)
        usage
        ;;
esac

