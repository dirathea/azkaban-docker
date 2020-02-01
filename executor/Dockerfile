FROM openjdk:8-slim-buster

COPY --from=dirathea/azkaban-base:3.81.0 /azkaban/azkaban-exec-server/build/install/azkaban-exec-server/ azkaban

WORKDIR /azkaban/bin

ENTRYPOINT [ "bash", "-c", "./start-exec.sh && sleep 1 && tail -f executorServerLog__*.out" ]