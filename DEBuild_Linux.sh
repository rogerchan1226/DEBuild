#!/bin/bash

# DEBuild means "Develop Environment Build"
# I created it for automatically build up my linux develop enviroment.

# DEBuild's tool packages & superuser privileges error detect
printf "\e[31m"
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
elif [ ! -f src/config ]; then
    echo 'ERROR!! "config" setting file lost !!'
    exit 1
fi
printf "\e[0m"

# Show logo and DEBuild version
printf "\e[32m"
cat src/version
printf "\e[0m"

# Choose the linux platform 
echo    "Which Linux platform you are using now?"
echo    "   1. Debian-based (Debian, Ubuntu, ...etc)"
echo    "   2. Fedora-based (Fedora, CentOS, ...etc)"
echo -n "Please select the option as above [1/2]: "
read selection

while [ $selection != "1" ] && [ $selection != "2" ]; do
    printf "\e[37;41m"
    echo -n "ERROR!" 
    printf "\e[0m"
    echo -n " 1 or 2 only, please select again [1/2]: "
    read selection
done

if [ $selection = "1" ]; then
    PKG_MANAGER=apt-get
    echo "PKG_MANAGER=apt-get" > src/settings.conf
else
    PKG_MANAGER=yum
    echo "PKG_MANAGER=yum" > src/settings.conf
fi

# Several config settings setup to "settings.conf"
source src/config

if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] && [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    printf "\e[31m"
        echo "Sublime install fail, can't turn on Stable/DEV both, Select one only."
    printf "\e[0m"
elif [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] || [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ]; then
        SUBL_VER=stable
    elif [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
        SUBL_VER=dev
    fi
    echo "CONFIG_SUBL_WILL_INSTALL=y" >> src/settings.conf
    echo "SUBL_PACK_SET = wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -" >> src/settings.conf
    echo "SUBL_PACK_SET += echo \"deb https://download.sublimetext.com/ apt/$SUBL_VER/\" | tee /etc/apt/sources.list.d/sublime-text.list" >> src/settings.conf
fi

# Install "make" command
if [ $selection = "1" ]; then
    $PKG_MANAGER update
    $PKG_MANAGER install -y make
else
    echo "Fedora-based not available yet.... Please wait for next version update!!"
    exit -1
fi

# Start install environment
pushd src/ || exit -1
make -f setup.mk
popd