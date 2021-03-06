# Install Apache and PHP
echo '********************************************************************************'
echo 'Upgrading the system'
sudo apt-get update; sudo apt-get upgrade

echo '********************************************************************************'
echo 'Installing apache2, php and mysql'
sudo apt-get install apache2 php5 mysql-server php5-mysql php5-mcrypt php5-curl php5-gd php-soap php5-tidy php5-imagick php-xml-parser -f -y

# Setup vhosts to work
echo '********************************************************************************'
echo 'Turning on required apache modules'
sudo a2enmod vhost_alias
sudo a2enmod alias
sudo a2enmod deflate
sudo a2enmod expires
sudo a2enmod status
sudo a2enmod rewrite
sudo a2enmod setenvif
sudo a2enmod headers
sudo a2enmod mime
sudo a2enmod ssl


if [ -d "/etc/apache2/ssl/" ] 				# Check to see if it already exists
then
	echo "Apache ssl directory is already created"
else
	echo "Setting up apache ssl directory"
	sudo mkdir /etc/apache2/ssl
fi 

if [ -d "/var/www/" ] 				# Check to see if it already exists
then
	echo "Apache www directory is already created"
else
	echo "Setting up apache www directory"
	sudo mkdir /var/www
fi 

if [ -d "/var/www/vhosts/" ] 				# Check to see if it already exists
then
	echo "VHOSTS Apache directory is already created"
else
	echo "Setting up apache vhosts directory"
	sudo mkdir /var/www/vhosts
fi 

echo '********************************************************************************'
echo 'Backing up default apache site'
sudo mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default_org
echo '********************************************************************************'
echo 'Copying vhosts apache config'
sudo cp ./apache2/sites-available/default /etc/apache2/sites-available/default

# php short tags

sudo service apache2 restart



# Install a mail service
sudo apt-get install postfix -f -y
echo '********************************************************************************'
echo ''
echo 'Make sure the hosts file has been setup ip.ip.ip.ip name.local name'
echo ''
echo 'Edit /etc/hosts configure this'
echo ''

# Webmin
wget http://downloads.sourceforge.net/project/webadmin/webmin/1.630/webmin_1.630_all.deb
sudo dpkg -i webmin_1.630_all.deb
sudo apt-get install -f -y
