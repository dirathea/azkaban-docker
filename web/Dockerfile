FROM openjdk:8-slim-buster

COPY --from=dirathea/azkaban-base:3.81.0 /azkaban/azkaban-web-server/build/install/azkaban-web-server/ azkaban

WORKDIR /azkaban/bin

ENTRYPOINT [ "bash", "-c", "./start-web.sh && sleep 1 && tail -f webServerLog_*.out" ]