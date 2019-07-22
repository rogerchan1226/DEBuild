#!/bin/bash

# DEBuild means "Develop Environment Build"
# I created it for automatically build up my linux develop enviroment.

# DEBuild tool packages & superuser privileges check
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
elif [ ! -f config ]; then
    echo 'ERROR!! "config" setting file lost !!'
    exit 1
fi

# Show logo and DEBuild version
source logo

# Choose the linux platform 
echo    "Which Linux platform you are using now?"
echo    "   1. Debian-based (Debian, Ubuntu, ...etc)"
echo    "   2. Fedora-based (Fedora, CentOS, ...etc)"
echo -n "Please select the option as above [1/2]: "
read selection

while [ $selection != "1" ] && [ $selection != "2" ]; do
    echo -n "ERROR! Please enter 1 or 2 only: "
    read selection
done

if [ $selection = "1" ]; then
    PKG_MANAGER="apt-get"
else
    PKG_MANAGER="yum"
fi

# Include ".config" settings file
source config

# Start install enviroment
if [ $selection = "1" ]; then
    $PKG_MANAGER update
    $PKG_MANAGER upgrade -y
else
    $PKG_MANAGER update -y
fi

if [ INSTALL_C_DEBuild=y ]; then
    $PKG_MANAGER install build-essential -y
fi

if [ INSTALL_GIT=y ]; then
    $PKG_MANAGER install git -y
fi

if [ INSTALL_SUBL_STABLE=y ]; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
    if [ $selection = "1" ]; then
        $PKG_MANAGER updated
    fi
    $PKG_MANAGER install sublime-text -y
elif [ INSTALL_SUBL_DEV=y ]; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
    echo "deb https://download.sublimetext.com/ apt/dev/" | tee /etc/apt/sources.list.d/sublime-text.list
    if [ $selection = "1" ]; then
        $PKG_MANAGER update
    fi
    $PKG_MANAGER install sublime-text -y
fi