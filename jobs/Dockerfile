FROM bash

RUN apk add git curl wget

COPY . /opt/bashdatacatalog

RUN chmod +x /opt/bashdatacatalog/bashdatacatalog /opt/bashdatacatalog/utils/bashdatacatalog* /opt/bashdatacatalog/jobs/download*

ENV PATH="${PATH}:/opt/bashdatacatalog"

ENTRYPOINT [ "bash" ]

