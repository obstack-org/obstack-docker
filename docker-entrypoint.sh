#!/bin/bash

echo "Starting ObStrack v1.1.0-b230617"

[[ ${#DB_CONNECTIONSTRING} -ne 0 ]] && {
  sed -i "/^\$db_connectionstring = /c\$db_connectionstring = '$DB_CONNECTIONSTRING';" var/lib/obstack/webapp/config.php;
}

httpd -DFOREGROUND