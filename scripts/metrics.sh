#!/bin/sh

NAMESPACE="robot-shop"

ENDPOINTS="cart:8080
catalogue:8080
dispatch:8080
mongodb:9216
mysql:9104
payment:8080
rabbitmq:15692
ratings:8080
redis:9121
shipping:8080
user:8080
web:9113"

clear
echo "Metric counts"
echo "============="
echo ""

for EP in $ENDPOINTS
do
    /bin/echo -n "$EP "
    SERVICE=$(echo "$EP" | cut -d: -f1)
    PORT=$(echo $EP | cut -d: -f2)
    TARGET="http://${SERVICE}.${NAMESPACE}.svc.cluster.local:${PORT}/metrics"
    curl -sL "$TARGET" | egrep '^[^#]' | wc -l
done
