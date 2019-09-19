git_info_input () {
    #enter information
    echo "Please enter your name :"
    read NAME
    echo "NAME=$NAME" >> src/settings.conf
    echo "please enter your email :"
    read EMAIL 
    echo "EMAIL=$EMAIL" >> src/settings.conf
}

if [ $CONFIG_GIT_INSTALL = "y" ]; then
    git_info_input        
fi