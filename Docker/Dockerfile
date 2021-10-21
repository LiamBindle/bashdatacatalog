FROM bash

RUN apk add git curl wget

COPY . /opt/bashdatacatalog

RUN chmod +x /opt/bashdatacatalog/bashdatacatalog /opt/bashdatacatalog/utils/bashdatacatalog* /opt/bashdatacatalog/Docker/download*

ENTRYPOINT [ "bash", "/opt/bashdatacatalog/Docker/download-missing" ]

