#!/bin/bash

E_NO_ARGS=65

if [ $# -eq 0 ]  						# Must have command-line args to create the reposotry.
then
	echo "  __________________________________________"
	echo "  You must specify a domain"
	echo "  e.g. "
	echo "  ./create_vhost_domain.sh domain.com"
	echo "  __________________________________________"
	exit $E_NO_ARGS
fi


if [ -d "/var/www/vhosts/" ] 				# Check to see if it already exists
then
	echo "VHOSTS Apache directory is already created"
else
	echo "Setting up apache vhosts directory"
	sudo mkdir /var/www/vhosts
fi 

if [ -d "/var/www/vhosts/$1" ] 				# Check to see if it already exists
then
	echo "$1 VHOSTS Apache directory is already created"
	echo "Now exiting"
else
	echo "Setting up apache vhosts directory for $1"

	sudo mkdir /var/www/vhosts/$1
	# Give ownership to www-data
	sudo chown :www-data /var/www/vhosts/$1 -R
	
	sudo mkdir /var/www/vhosts/$1/logs
	sudo chown :www-data /var/www/vhosts/$1/logs/ -R
	sudo chmod 660 /var/www/vhosts/$1/logs/ -R

	# TODO Copy the config file and replace $1 with the {site_name} with sed or something.

	# Reload apahce2
	sudo service apache2 reload
fi 

