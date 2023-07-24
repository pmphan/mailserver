FROM alpine:3.18.2

EXPOSE 8891

VOLUME /etc/dkim/keys

RUN apk add --no-cache bash supervisor opendkim opendkim-utils

COPY etcfs /etc

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
