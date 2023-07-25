FROM alpine:3.18.2

EXPOSE 25 587

RUN apk add --no-cache bash postfix postfix-pgsql cyrus-sasl cyrus-sasl-crammd5 cyrus-sasl-digestmd5 cyrus-sasl-login cyrus-sasl-ntlm

ADD etcfs /etc

WORKDIR /opt

COPY scripts scripts

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
