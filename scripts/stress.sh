#!/bin/sh

stress-ng \
    --timeout 600 \
    --metrics \
    --vfork 1
