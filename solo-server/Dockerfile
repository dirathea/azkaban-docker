FROM openjdk:8-slim-buster

COPY --from=dirathea/azkaban-base:3.81.0 /azkaban/azkaban-solo-server/build/install/azkaban-solo-server/ azkaban

WORKDIR /azkaban/bin

ENTRYPOINT [ "bash", "-c", "./start-solo.sh && sleep 1 && tail -f soloServerLog__*.out" ]