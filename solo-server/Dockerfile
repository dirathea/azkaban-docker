ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base
FROM openjdk:8-slim-buster

COPY --from=base /azkaban/azkaban-solo-server/build/install/azkaban-solo-server/ azkaban

WORKDIR /azkaban/bin

ENTRYPOINT [ "bash", "-c", "./start-solo.sh && sleep 1 && tail -f soloServerLog__*.out" ]