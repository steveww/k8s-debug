FROM alpine:3.10

RUN apk update && apk add bash curl iputils bind-tools busybox-extras

COPY scripts/sleeper.sh /opt/
COPY scripts/bashrc /root/.bashrc

CMD /opt/sleeper.sh

