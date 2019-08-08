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

# Ask user if start install packages or not
echo    "Do you want to install following packages?   "
    source src/setup.sh
echo -n "Answer [Y/n]: "

install_yn () {
    read answer
    case $answer in
        [Yy] | [Yy][Ee][Ss] )
            echo "Start install... "
            ;;
        [Nn] | [Nn][Oo] )
            echo "End !"
            exit -1
            ;;
        * )
            printf "\e[37;41m"
                echo -n "ERROR!" 
            printf "\e[0m"
            echo    " Sorry, answer not recognized"
            echo -n "Please answer again... [Y/n]: "
            install_yn
            ;;
    esac
}

install_yn

# Choose the linux platform 
platform_select () {
    case $selection in
        1 )
            PKG_MANAGER=apt-get
            echo "PKG_MANAGER=apt-get" > src/settings.conf
            ;;
        2 )
            PKG_MANAGER=yum
            echo "PKG_MANAGER=yum" > src/settings.conf
            ;;
        * )
            printf "\e[37;41m"
                echo -n "ERROR!" 
            printf "\e[0m"
            echo -n " 1 or 2 only, please select again [1/2]: "
            input_pselect
            ;;
    esac
}

input_pselect () {
    read selection
    platform_select
}

platform () {
    echo    "Which Linux platform you are using now?    "
    echo    "   1. Debian-based (Debian, Ubuntu, ...etc)"
    echo    "   2. Fedora-based (Fedora, CentOS, ...etc)"
    echo -n "Please select the option as above [1/2]: "
    input_pselect
}

echo "Detect platform Name..."

if [ -f /etc/\*-release ]; then
    echo "Platform detect FAIL!!!"
    platform
else
    # String processing
    platform_value=`cat /etc/*-release | grep 'ID_LIKE=' | cut -d"=" -f 2`
    ## echo $platform_value
    case $platform_value in
        debian )
            printf "\e[37;42m"
                echo -n "PASS" 
            printf "\e[0m"
            echo " Oh~ you are Debian-based user huh.."
            selection=1
            platform_select
            ;;
        Fedora )
            printf "\e[37;42m"
                echo -n "PASS" 
            printf "\e[0m"
            echo " Oh~ you are Fedora-based user huh.."
            selection=2
            platform_select
            ;;
        * )
            echo "Platform detect FAIL!!!"
            platform
            ;;
    esac
fi



# Several config settings setup to "settings.conf"
if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] || [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
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
    make -f install.mk
popd