#!/usr/bin/env bash

if [ -f /etc/redhat-release ]; then
  sudo dnf install -y httpd mod_ssl
  sudo dnf install -y mysql mysql-server

  sudo systemctl start mariadb.service
  echo -e "\n\nroot\nroot\n\n\nn\n\n " | sudo mysql_secure_installation 2>/dev/null
  sudo systemctl stop mariadb.service

  sudo dnf install -y php php-opcache php-mcrypt php-mysql php-apc php-gd
  sudo sed -i.bak -e 's/upload_max_filesize = 2M/upload_max_filesize = 28M/g; s/post_max_size = 8M/post_max_size = 32M/g' /etc/php.ini

  sudo dnf install -y phpMyAdmin
  sudo sed -n -i.bak '/?>/q;p'  /etc/phpMyAdmin/config.inc.php

  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

  sudo dnf install -y nodejs npm
  sudo npm install -g bower
  sudo npm install -g gulp

  sudo usermod -a -G apache $USER
  sudo chgrp -R apache /var/www/html
  sudo chmod -R g+w /var/www/html
  sudo chmod g+s /var/www/html