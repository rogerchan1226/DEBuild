


# Sublime install version check
if [ $CONFIG_IDE_SUBL_STABLE_INSTALL = "y" ] || [ $CONFIG_IDE_SUBL_DEV_INSTALL = "y" ]; then
    source src/subl/subl_set.sh
fi

# Include "git" setting options
if [ $CONFIG_GIT_INSTALL = "y" ] && [ $CONFIG_GIT_COMMANDS_SETUP = "y" ]; then
    source src/git/git_set.sh
fi
