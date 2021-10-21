FROM bash

RUN apk add git curl wget

COPY . /opt/bashdatacatalog

ENTRYPOINT [ "bash", "/opt/bashdatacatalog/Docker/download-missing" ]

