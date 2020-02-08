FROM openjdk:8-stretch

ARG AZKABAN_VERSION=3.81.0

ENV AZKABAN_DOWNLOAD_URL https://github.com/azkaban/azkaban/archive/${AZKABAN_VERSION}.zip

RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/* && \
    wget ${AZKABAN_DOWNLOAD_URL}

RUN unzip ${AZKABAN_VERSION}.zip && \
    mv azkaban-${AZKABAN_VERSION} azkaban && \
    cd azkaban && \
    ./gradlew installDist
