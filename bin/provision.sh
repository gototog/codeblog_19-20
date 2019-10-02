#!/usr/bin/env bash

APP_DIR="/var/www/codeblog"
APP_NAME="codeblog"
APACHE_VHOST_FILE="/etc/apache2/sites-available/${APP_NAME}.conf"

#
# install basic
#
echo "install generic packages needed";
apt-get update
apt-get -y install build-essential nano git curl vim apt-transport-https lsb-release ca-certificates acl



#
# PHP
#
echo "### PHP";
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

apt update
apt install -y php7.2 php7.2-fpm php7.2-gd php7.2-mysql php7.2-cli php7.2-common php7.2-curl php7.2-opcache php7.2-json php7.2-msgpack php7.2-memcached php7.2-intl php7.2-sqlite3 php7.2-gmp php7.2-geoip php7.2-mbstring php7.2-xml php7.2-zip
echo " PHP VERSION "
php -v




#
# APACHE2
#
echo "### APACHE2";
apt-get -y install apache2 > /dev/null
apt install -y apache2 libapache2-mod-php7.2

a2enmod proxy_fcgi
a2enconf php7.2-fpm

# change access right to apache
sed -i 's/group\ \=\ www\-data/group = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/user\ \=\ www\-data/user = vagrant/' /etc/php/7.2/fpm/pool.d/www.conf
sed -i 's/^export APACHE_RUN_GROUP=www\-data/export APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars
sed -i 's/^export APACHE_RUN_USER=www\-data/export APACHE_RUN_USER=vagrant/' /etc/apache2/envvars

# log dir
mkdir /var/log/apache2/${APP_NAME};

# vhost
echo "vhost: ${APACHE_VHOST_FILE}";
cat << EOF > ${APACHE_VHOST_FILE}
<VirtualHost *:80>
    ServerName ${APP_NAME}.local

    DocumentRoot ${APP_DIR}/public
    <Directory ${APP_DIR}/public>
        AllowOverride All
        Order Allow,Deny
        Allow from All
        FallbackResource /index.php
    </Directory>
    <Directory ${APP_DIR}/public/bundles>
        FallbackResource disabled
    </Directory>

    ErrorLog /var/log/apache2/${APP_NAME}/error.log
    CustomLog /var/log/apache2/${APP_NAME}/access.log combined
</VirtualHost>
EOF


a2dissite 000-default
rm /etc/apache2/sites-available/000-default.conf
rm /etc/apache2/sites-available/default-ssl.conf
a2ensite ${APP_NAME}

a2enmod rewrite

service apache2 reload


#
# Composer
#
echo "### Composer";
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



#
# Mysql
#
echo "### Mysql";
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get update > /dev/null
apt-get install -y mysql-server

#
# Mailcatcher
#
echo "### Mailcatcher";
apt-get install -y ruby-dev libsqlite3-dev
gem install mailcatcher

exit 0