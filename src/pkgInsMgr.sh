


# Install "Sublime" job
if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] || [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    source src/appsrc/subl/subl_set.sh
fi

# Install "git" job
if [ $CONFIG_GIT_INSTALL = "y" ] && [ $CONFIG_GIT_COMMANDS_SETUP = "y" ]; then
    source src/appsrc/git/git_set.sh
fi
