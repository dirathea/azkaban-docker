ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base

FROM openjdk:8-stretch

COPY --from=base /azkaban/azkaban-solo-server/build/install/azkaban-solo-server/ azkaban

WORKDIR /azkaban
COPY bootstrap.sh bin/
RUN chmod +x bin/bootstrap.sh

ENTRYPOINT [ "bin/bootstrap.sh" ]