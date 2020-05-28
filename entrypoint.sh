#!/bin/bash

echo "default_authentication_plugin=mysql_native_password" >> \
    /etc/mysql/conf.d/docker.cnf

source /usr/local/bin/docker-entrypoint.sh

_main mysqld --socket=/tmp/mysql.sock &> /dev/null &

echo -n "Waiting for mysql"
until mysqladmin ping --socket /tmp/mysql.sock --silent; do
  >&2 echo -n "."
  sleep 1
done

exec "$@"
