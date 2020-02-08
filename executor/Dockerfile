ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base

FROM openjdk:8-stretch

COPY --from=base /azkaban/azkaban-exec-server/build/install/azkaban-exec-server/ azkaban

WORKDIR /azkaban/bin
COPY bootstrap.sh .
RUN chmod +x bootstrap.sh

ENTRYPOINT [ "./bootstrap.sh" ]