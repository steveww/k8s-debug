FROM alpine

RUN apk add --update --no-cache \
    bash curl iputils bind-tools dhcping dhcpcd busybox-extras \
    jq yq stress-ng hey && \
    rm -rf /var/cache/apk/*

COPY scripts/sleeper.sh /opt/
COPY scripts/bashrc /root/.bashrc

CMD /opt/sleeper.sh

