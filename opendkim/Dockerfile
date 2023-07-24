FROM alpine:3.18.2

EXPOSE 8891

VOLUME /etc/dkim/keys

RUN apk add --no-cache bash opendkim opendkim-utils

COPY config /etc/opendkim

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
