FROM postfixadmin:3.3

COPY config.local.php /var/www/html

ADD apache /etc/apache2

RUN a2ensite default-ssl && a2enmod rewrite && a2enmod ssl

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["apache2-foreground"]
