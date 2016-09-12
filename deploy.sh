#!/bin/bash

set -e
IPADDR=$1

cat << 'EOF' > "cmd.txt"
  echo ===== Deploying... =====

  cd /home/isucon/private_isu/webapp

  CURRENT_COMMIT=`git rev-parse HEAD`

  git pull origin master

  cd ruby

  echo ===== Rotate log files =====
  if [ -f /var/lib/mysql/mysqld-slow.log ]; then
    sudo mv /var/lib/mysql/mysqld-slow.log /var/lib/mysql/mysqld-slow.log.$(date "+%Y%m%d_%H%M%S").$CURRENT_COMMIT
  fi
  if [ -f /var/log/nginx/access.log ]; then
    sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$(date "+%Y%m%d_%H%M%S").$CURRENT_COMMIT
  fi

  echo ===== Bundle Install =====
  ~/.local/ruby/bin/bundle install

  echo ===== Copy my.cnf  =====
  if [ -f /etc/mysql/my.cnf ]; then
    sudo rm /etc/mysql/my.cnf
  fi

  sudo cp ../config/my.cnf /etc/mysql/my.cnf

  echo ===== Restart MySQL =====
  sudo service mysql restart

  echo ===== Copy nginx.conf  =====
  if [ -f /etc/nginx/nginx.conf ]; then
    sudo rm /etc/nginx/nginx.conf
  fi

  sudo cp ../config/nginx.conf /etc/nginx/nginx.conf

  echo ===== Restart nginx =====
  sudo systemctl restart nginx

  echo == Start unicorn ==
  sudo systemctl restart isu-ruby

  echo ===== Restart sysctl =====
  sudo sysctl -p

  echo ===== FINISHED =====
EOF

cmd=`cat "cmd.txt"`
rm "cmd.txt"

ssh isucon@$IPADDR "${cmd}"
