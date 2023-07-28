FROM alpine:3.18.2

EXPOSE 24 143 993 9993

RUN apk add --no-cache bash dovecot dovecot-lmtpd dovecot-pgsql

ADD etcfs /etc

WORKDIR /opt

COPY scripts scripts

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["/usr/sbin/dovecot", "-F"]
