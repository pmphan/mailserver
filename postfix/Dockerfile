FROM alpine:3.18.2

WORKDIR /opt

RUN apk add --no-cache bash postfix

COPY config/*.cf /etc/postfix/

COPY . .

EXPOSE 587

ENTRYPOINT ["./docker-entrypoint.sh"]
