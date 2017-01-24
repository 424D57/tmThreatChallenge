#!/bin/bash

#Instructions to use this script 
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh


echo "#############################"
echo "Installing Apache, & Git PHP"
echo "#############################"

#Update the repositories

sudo apt-get update

#Apache, Php, and required packages installation

sudo apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-gd php5-cli php5-dev
php5enmod mcrypt git

#Restart apache2 to verify that everything is installed properly

echo -e "\n"

service apache2 restart

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

echo -e "\n"

#Downloading challenges from github

echo "Downloading Challenges from GitHub Repo"
git clone 
