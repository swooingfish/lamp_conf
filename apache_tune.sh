#!/bin/bash

# Help taken from http://nls.io/post/how-do-i-calculate-apache-maxclients-

# Get the total memory of the box
mem_total=`free -m | grep 'Mem:' | awk '{print $2}'`
echo ""
echo " ****************************************************"
echo " ************ Apache2 Max Clients Tuning ************"
echo ""
echo ""
echo "    Total memory available: $mem_total MB"
echo "" 

# Work out the apache2 average memory used
mem_apache2_avg=`ps aux | grep 'apache2' | awk '{print $6/1024;}' | awk '{avg += ($1 - avg) / NR;} END {print avg}'`
mem_apache2_max=`ps aux | grep 'apache2' | awk '{print $6/1024;}' | awk '{if (max < $1 ) max = $1;} END {print max}'`
echo "    Avg Apache Process is using $mem_apache2_avg MB"
echo "    Max Apache Process is using $mem_apache2_max MB"
echo ""
max_clients_current=`cat /etc/apache2/apache2.conf |grep 'MaxClients '| awk '{if (max < $2 ) max = $2;} END {print max}'`

# Work out potential memory use for apache
apache_potential_avg=`echo $max_clients_current $mem_apache2_avg|awk '{print $1*$2}'`
apache_potential_max=`echo $max_clients_current $mem_apache2_max|awk '{print $1*$2}'`
echo "    Total Avg potential memory use for apache: $apache_potential_avg MB" 
echo "    Total Max potential memory use for apache: $apache_potential_max MB" 
echo ""

# Work out mysql memory used
mem_mysql_avg=`ps aux | grep 'mysql' | awk '{print $6/1024;}' | awk '{avg += ($1 - avg) / NR;} END {print avg}'`
mem_mysql_max=`ps aux | grep 'mysql' | awk '{print $6/1024;}' | awk '{if (max < $1 ) max = $1;} END {print max}'`
echo "    Avg MySQL Process is using $mem_mysql_avg MB"
echo "    Max MySQL Process is using $mem_mysql_max MB" 
echo ""

# Get system ram used and other processes
mem_system_other=`ps aux | awk '{sum1 +=$4}; END {print sum1}'`
echo "    Ram used by the system and other processes $mem_system_other MB"
echo ""

# Get the max clients and take one off just for good measure
max_clients=`echo $mem_total $mem_system_other $mem_apache2_avg|awk '{printf("%d",($1-$2)/$3)} ' | awk '{print $1-1}'`
echo "    Max clients can be increased to around $max_clients"
echo ""
echo "    Your Max clients set in /etc/apache2/apache2.conf"
cat /etc/apache2/apache2.conf |grep 'MaxClients '
echo " ****************************************************"
echo " ab -n 1000 -c 300 http://localhost/"
echo ""




