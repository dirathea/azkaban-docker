ARG BASE_VERSION=latest
FROM dirathea/azkaban-base:${BASE_VERSION} as base

FROM alpine:3.11

RUN apk add --no-cache \
    mysql-client

COPY --from=base /azkaban/azkaban-db/build/sql/create-all-sql-0.1.0-SNAPSHOT.sql create-all-sql.sql
COPY bootstrap.sh bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT [ "/bootstrap.sh" ]