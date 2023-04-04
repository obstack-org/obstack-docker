FROM    alpine:3.17

RUN     apk add --no-cache bash apache2 apache2-http2 php-apache2 php-session php-ldap php-json php-pdo_pgsql php-pdo_mysql

ADD     error.conf /etc/apache2/conf.d/error.conf

RUN     sed -i '/^expose_php/c\expose_php = Off' /etc/php*/php.ini && \
        echo -e "\nProtocols h2 h2c http/1.1\n" >>/etc/apache2/conf.d/http2.conf && \
        sed -i -e '/^ServerTokens/c\ServerTokens Prod' -e '/^ServerSignature/c\ServerSignature Off' /etc/apache2/httpd.conf

RUN     apk add --no-cache git \
        && cd /var/lib \
        && git clone "https://github.com/obstack-org/obstack.git" \
        && ln -s /var/lib/obstack/webapp /var/www/localhost/htdocs/obstack

ENV     DB_CONNECTIONSTRING=""

ADD     docker-entrypoint.sh /docker-entrypoint.sh
CMD     /docker-entrypoint.sh