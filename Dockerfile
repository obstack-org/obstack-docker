FROM    alpine:3.17

ADD     docker-entrypoint.sh /docker-entrypoint.sh
ADD     error.conf /etc/apache2/conf.d/error.conf

RUN     apk add --no-cache bash openssl apache2 apache2-http2 apache2-ssl php-apache2 php-mbstring php-session php-ldap php-json php-pdo_pgsql php-pdo_mysql

RUN     rm -f /etc/ssl/apache2/* && \
        sed -i '/^expose_php/c\expose_php = Off' /etc/php*/php.ini && \
        echo -e "\nProtocols h2 h2c http/1.1\n" >>/etc/apache2/conf.d/http2.conf && \
        sed -i -e '/^ServerTokens/c\ServerTokens Prod' -e '/^ServerSignature/c\ServerSignature Off' /etc/apache2/httpd.conf

RUN     apk add --no-cache git && \
        cd /var/lib && \
        git clone "https://github.com/obstack-org/obstack.git" && \
        ln -s /var/lib/obstack/webapp /var/www/localhost/htdocs/obstack && \
        echo '<html><head><meta http-equiv="refresh" content="0; url=./obstack"></head></html>' >/var/www/localhost/htdocs/index.html

CMD     /docker-entrypoint.sh
