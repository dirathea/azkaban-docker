ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base

FROM openjdk:8-stretch

COPY --from=base /azkaban/azkaban-web-server/build/install/azkaban-web-server/ azkaban

WORKDIR /azkaban/bin
COPY bootstrap.sh .
RUN chmod +x bootstrap.sh

ENTRYPOINT [ "./bootstrap.sh" ]