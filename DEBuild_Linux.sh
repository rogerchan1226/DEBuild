#!/bin/bash

# DEBuild means "Develop Environment Build"
# I created it for automatically build up my linux develop enviroment.

# DEBuild tool packages & superuser privileges check
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
elif [ ! -f src/config ]; then
    echo 'ERROR!! "config" setting file lost !!'
    exit 1
fi

# Show logo and DEBuild version
source src/version

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
    echo "PKG_MANAGER=apt-get" > src/settings.conf
else
    echo "PKG_MANAGER = yum" > src/settings.conf
fi

# Several config settings setup to "settings.conf"
source src/config
if [ IDE_SUBL_STABLE_INSTALL=y ]; then
    echo "SUBL_VER=stable" >> src/settings.conf
elif [ IDE_SUBL_DEV_INSTALL=y ]; then
    echo "SUBL_VER=dev" >> src/settings.conf
fi

if [ IDE_SUBL_STABLE_INSTALL=y ] ||
   [ IDE_SUBL_DEV_INSTALL=y ]; then
    echo "SUBL_WILL_INSTALL=y" >> src/settings.conf
    echo "SUBL_PACK_SET = wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -" >> src/settings.conf
    echo "SUBL_PACK_SET += echo \"deb https://download.sublimetext.com/ apt/\$(SUBL_VER)/\" | tee /etc/apt/sources.list.d/sublime-text.list" >> src/settings.conf
fi

# Start install environment
cd src
make -f setup.mk