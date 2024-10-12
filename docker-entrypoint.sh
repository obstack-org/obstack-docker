#!/bin/bash

echo -e "Starting ObStack v1.2.2\n"

[[ ${#SSL_CERTIFICATEFILE} -ne 0 ]] && [[ ${#SSL_CERTIFICATEKEYFILE} -ne 0 ]] && {
  echo -e "$SSL_CERTIFICATEFILE" >/etc/ssl/apache2/server.pem
  echo -e "$SSL_CERTIFICATEKEYFILE" >/etc/ssl/apache2/server.key
}
[[ ! -f /etc/ssl/apache2/server.pem ]] && {
  rm -f /etc/ssl/apache2/server.key
  openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/CN=obstack.example.local" -keyout /etc/ssl/apache2/server.key -out /etc/ssl/apache2/server.pem &>/dev/null
}

mkdir -pm 750 /etc/obstack
[[ ${#DB_CONNECTIONSTRING} -ne 0 ]] && {
  echo "db_connectionstring = $DB_CONNECTIONSTRING" >>/etc/obstack/obstack.conf;
}
[[ ${#SC_ENCRYPTIONKEY} -lt 12 ]] && {
  echo "WARNING!: Invalid encryption key, please check the documentation:";
} || {
  echo "Encryption key set. Please read the documentation when using this function:";
  echo "sc_encryptionkey = $SC_ENCRYPTIONKEY" >>/etc/obstack/obstack.conf;
}
echo -e "  http://www.obstack.org/docs/?doc=general-configuration#configuring-recoverable-passwords\n"
chown -R root:apache /etc/obstack

[[ ${#PHP_UPLOADMAXFILESIZE} -ne 0 ]] && {
  sed -i "/^upload_max_filesize/c\upload_max_filesize = $PHP_UPLOADMAXFILESIZE" /etc/php*/php.ini
}

httpd -DFOREGROUND