FROM alpine:3.18.2

EXPOSE 24 143 993 9993

RUN apk add --no-cache dovecot dovecot-pgsql

ADD etcfs /etc

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["usr/sbin/dovecot", "-F"]
