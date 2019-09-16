source src/config


# Check out if there got wrong settings
if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] && [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    printf "\e[37;41m"
        echo -n "ERROR!" 
    printf "\e[0m"
    echo " Sublime install fail, can't turn on Stable/DEV both, Select one only."
	exit -1
fi

total_pkgs=0

# Install packages log pre process.
	echo " __________________________"
	echo "|                          |"
if [ $CONFIG_GIT_INSTALL = "y" ]; then
	echo "| Git                      |"
	total_pkgs=$((total_pkgs + 1))
fi

if [ $CONFIG_INSTALL_C_DEBuild = "y" ]; then
	echo "| Build-essential          |"
	total_pkgs=$((total_pkgs + 1))
fi

if [ $CONFIG_INSTALL_CLIB = "y" ]; then
	echo "| Several C Library        |"
	total_pkgs=$((total_pkgs + 1))
fi

if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ]; then
	echo "| Sublime stable version   |"
	total_pkgs=$((total_pkgs + 1))
fi

if [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
	echo "| Sublime develop version   |"
	total_pkgs=$((total_pkgs + 1))
fi

if [ $total_pkgs = "0" ]; then
	echo "| NONE                     |"
	echo "|__________________________|"
	printf "\e[37;41m"
        echo -n "ERROR!" 
    printf "\e[0m"
	echo " There is no packages will be install, please checkout \"src/config\" and try again."
	exit -1
else
	echo "|__________________________|"
fi