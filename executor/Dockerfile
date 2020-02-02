ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base
FROM openjdk:8-slim-buster

COPY --from=base /azkaban/azkaban-exec-server/build/install/azkaban-exec-server/ azkaban

WORKDIR /azkaban/bin

ENTRYPOINT [ "bash", "-c", "./start-exec.sh && sleep 1 && tail -f executorServerLog__*.out" ]