FROM alpine:3.18.2

WORKDIR /opt

RUN apk add --no-cache bash postfix

COPY main.cf /etc/postfix/main.cf

COPY . .

EXPOSE 25

ENTRYPOINT ["./docker-entrypoint.sh"]
