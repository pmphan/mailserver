FROM alpine:3.18.2

EXPOSE 25 587

RUN apk add --no-cache bash postfix

COPY config /etc/postfix

WORKDIR /opt

COPY docker-entrypoint.sh .

COPY scripts scripts

ENTRYPOINT ["./docker-entrypoint.sh"]
