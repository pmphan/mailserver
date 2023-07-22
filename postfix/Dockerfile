FROM alpine:3.18.2

RUN apk add --no-cache bash postfix

COPY config /etc/postfix

WORKDIR /opt

COPY docker-entrypoint.sh .

COPY scripts ./scripts

EXPOSE 24 587

ENTRYPOINT ["./docker-entrypoint.sh"]
