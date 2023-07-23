FROM alpine:3.18.2

EXPOSE 8891

VOLUME /etc/opendkim/keys

RUN apk add --no-cache opendkim opendkim-utils

COPY config /etc/opendkim

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
