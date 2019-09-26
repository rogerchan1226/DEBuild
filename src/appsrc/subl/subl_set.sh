




# Several config settings setup to "settings.conf"
if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ]; then
    SUBL_VER=stable
elif [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    SUBL_VER=dev
fi
echo "CONFIG_SUBL_WILL_INSTALL=y" >> src/settings.conf
echo "SUBL_PACK_SET = wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -" >> src/settings.conf
echo "SUBL_PACK_SET += echo \"deb https://download.sublimetext.com/ apt/$SUBL_VER/\" | tee /etc/apt/sources.list.d/sublime-text.list" >> src/settings.conf