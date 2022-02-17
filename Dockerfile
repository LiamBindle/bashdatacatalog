FROM bash

RUN apk add git curl wget

COPY . /opt/bashdatacatalog

RUN chmod +x /opt/bashdatacatalog/bin/*

ENV PATH="${PATH}:/opt/bashdatacatalog/bin"

ENTRYPOINT [ "bash" ]
