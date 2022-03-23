#!/usr/bin/env bash

#variable von db
DBHOST=localhost
DBNAME=UME
DBUSER=root
DBPASSWD=ume
DBTSCHUELER=user
TABLE1=werischume
TABLE2=werischnödume

# all packages getting updated
sudo apt-get update

# set up mysql and phpmyadmin with password and connect with db
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $DBPASSWD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

# install mysql and admin interface
sudo apt-get -y install mysql-server phpmyadmin

# create db and tables
mysql -uroot -p$DBPASSWD <<%EOF%
	CREATE USER '$DBUSER'@'$DBHOST' IDENTIFIED BY '$DBPASSWD';
	GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'$DBHOST' IDENTIFIED BY '$DBPASSWD' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	CREATE DATABASE $DBNAME;
	USE $DBNAME;
	CREATE TABLE $TABLE1(PersonID INT(50), Vorname VARCHAR(50), Name VARCHAR(50), PRIMARY KEY (PersonID));
	CREATE TABLE $TABLE2 (NotenID INT(50), Schulfach VARCHAR(50), Note VARCHAR(50), PersonID INT(50), PRIMARY KEY (NotenID), FOREIGN KEY (PersonID) REFERENCES Schueler(PersonID));
	INSERT INTO $TABLE1 VALUE ("1","Meset","Helper");
	INSERT INTO $TABLE1 VALUE ("2","Luca","ume");
	INSERT INTO $TABLE1 VALUE ("3","Elias","wer");
	INSERT INTO $TABLE1 VALUE ("4","9i","Jakup");
	INSERT INTO $TABLE2 VALUE ("1","LB1", "5", "1" );
	INSERT INTO $TABLE2 VALUE ("2","LB1", "6", "2" );
	INSERT INTO $TABLE2 VALUE ("3","LB1", "5.5", "3" );
	INSERT INTO $TABLE2 VALUE ("4","LB1", "5.5", "4" );
	quit
%EOF%	

cd /vagrant

# update mysql conf file to allow remote access to the db 
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

sudo service mysql restart

# setup phpmyadmin

sudo service apache2 restart
