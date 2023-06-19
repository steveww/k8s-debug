FROM golang:1.19 AS build
WORKDIR /app

COPY app /app/
RUN CGO_ENABLED=0 go build -o app


FROM alpine

RUN apk add --update --no-cache \
    bash curl iputils bind-tools dhcping dhcpcd busybox-extras \
    util-linux-misc jq yq stress-ng hey && \
    rm -rf /var/cache/apk/*

COPY --from=build /app/app /app/app
COPY scripts/ /opt/
COPY scripts/bashrc /root/.bashrc

CMD ["/app/app"]
