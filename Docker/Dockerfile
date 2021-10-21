FROM bash

RUN apk add git curl wget

COPY . /opt/bashdatacatalog

ENTRYPOINT [ "/opt/bashdatacatalog/Docker/download-missing" ]

