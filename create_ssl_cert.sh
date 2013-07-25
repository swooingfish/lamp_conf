#!/bin/bash

E_NO_ARGS=65

if [ $# -eq 0 ]  						# Must have command-line args to create the reposotry.
then
	echo "  __________________________________________"
	echo "  You must specify a domain name for the key"
	echo "  e.g. "
	echo "  ./create_ssl_cert.sh domain.com"
	echo "  __________________________________________"
	exit $E_NO_ARGS
fi

if [ -d "/etc/apache2/ssl" ] 				# Check to see if it already exists
then
	echo "SSL Apache directory is already created"
else
	echo "Setting up apache ssl directory to store ssl keys"
	sudo mkdir /etc/apache2/ssl
fi 

if [ -f "/etc/apache2/ssl/$1.key" ] 				# Check to see if it already exists
then
	echo ""
	echo "  The ssl key $1.key already exists, please try again."
	echo ""
else
	echo "*************************************************** "
	echo "Creating SSL Key..."
	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/$1.key -out /etc/apache2/ssl/$1.crt
	echo ""
	echo "SSL Key created : $1.key"
	echo "SSL cert created : $1.crt"
	echo ""
	echo "You can now setup this in the /etc/apache2/sites-available "
	echo ""
	echo "SSLEngine on"
	echo "SSLCertificateFile /etc/apache2/ssl/$1.crt"
	echo "SSLCertificateKeyFile /etc/apache2/ssl/$1.key"
	echo ""
	echo "*************************************************** "
fi



