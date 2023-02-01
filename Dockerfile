FROM alpine

RUN apk add --update --no-cache \
    bash curl iputils bind-tools dhcping dhcpcd busybox-extras \
    util-linux-misc jq yq stress-ng hey && \
    rm -rf /var/cache/apk/*

COPY scripts/ /opt/
COPY scripts/bashrc /root/.bashrc

CMD /opt/sleeper.sh

