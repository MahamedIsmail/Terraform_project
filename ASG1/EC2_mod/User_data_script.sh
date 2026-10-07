#!/bin/bash
#######################################################################
# Phase 1 installation
######################################################################
set -x
# Instals wordpress depinces software php, sql compatilbe database i chose mariadb and  w get)

dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel php-gd -y

# dowloads the latest wordpress with dowlading tool wget

wget https://wordpress.org/latest.tar.gz

# Unzips and unarchives the installed package, the folder is called wordpress

tar -xzf latest.tar.gz
# Start my datbase and webserver (mariadb,apche)

sudo systemctl start mariadb httpd

#######################################################################
# Phase 2  configure database
######################################################################

# Log in as root use  password
# creat a user, witch can only accses db from loclly (from the ec2 machine) 
# Creat users deticated db for his wordpress site.
# give all premmsions update delte add etc on db wordpress-db including all tabels ( structed data records) to my user 
# Make my changes immediately
mysql -u root -p'${root_password}' -e "CREATE USER '${user}'@'${hostname}' IDENTIFIED BY '${your_strong_password}';CREATE DATABASE ${Database_name};GRANT ALL PRIVILEGES ON ${Database_name}.* TO '${user}'@'${hostname}';FLUSH PRIVILEGES;"


#######################################################################
# Phase 3 configure wordpress
######################################################################

# copy the wp-config-sample.php(configration file you define in php) make it your own 

cp wordpress/wp-config-sample.php wordpress/wp-config.php


# Starts text editor to conifure our config file, define writes our values to configuer it

sed -i "s/database_name_here/${Database_name}/"  wordpress/wp-config.php

sed -i "s/username_here/${user}/" wordpress/wp-config.php

sed -i "s/password_here/${your_strong_password}/" wordpress/wp-config.php

# to secury website cookies you define keys and salt values, i do not use them for this project.


#######################################################################
# Phase 4 configure apache httpd
######################################################################

# copyes my wordpress installtion files including my wordpress configuretion to my achpe webserves document. to be run in my root domain 

cp -r wordpress/* /var/www/html/

# # Change owner:group to apache:apache 

sudo chown -R apache:apache /var/www   
# changes dir permission to let groups + owners rwx while other only rx
# Then do the same thing to all subdir in /var/www

sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
# Change all filles under to ow=rw g+other=r /no exuction on files 

find /var/www -type f -exec sudo chmod 0644 {} \;
# Restart the webserver to apply the new permissions 

sudo systemctl restart httpd


#######################################################################
# Phase 5 run wordpress
#######################################################################

# making sure server and db starts at every reboot

sudo systemctl enable httpd && sudo systemctl enable mariadb
# verfify db server is runing 

sudo systemctl status mariadb
# starts db 
sudo systemctl start mariadb

# verify webserver is runing
sudo systemctl status httpd

# start webserver

sudo systemctl start httpd