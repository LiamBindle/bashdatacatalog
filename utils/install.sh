#!/usr/bin/env bash

read -e -p "> Enter install prefix [$HOME]: " INSTALL_PREFIX
INSTALL_PREFIX=${INSTALL_PREFIX:-$HOME}

while [ ! -d $INSTALL_PREFIX ]; do
    read -e -p "> Invalid path. Enter install prefix [$HOME]: " INSTALL_PREFIX
    INSTALL_PREFIX=${INSTALL_PREFIX:-$HOME}
done

cd $INSTALL_PREFIX

if [ -d .bashdatacatalog ]; then
    echo "An installation already exists. Updating it ..."
    cd .bashdatacatalog
    git pull
    cd ..
else
    echo "Downloading ..."
    git clone https://github.com/LiamBindle/bashdatacatalog.git .bashdatacatalog
fi

while true; do
    read -p "> Do you want to add this installation to your \$PATH? [Y/n]: " YESNO
    YESNO=${YESNO:-Y}
    case $YESNO in
    [Yy])
        read -e -p "> Enter your environment file [$HOME/.bashrc]: " ENVIRONMENT_FILE
        ENVIRONMENT_FILE=${ENVIRONMENT_FILE:-$HOME/.bashrc}

        while [ ! -f $ENVIRONMENT_FILE ]; do
            read -p "> Invalid path. Enter your environment file [$HOME/.bashrc]: " ENVIRONMENT_FILE
            ENVIRONMENT_FILE=${ENVIRONMENT_FILE:-$HOME/.bashrc}
        done

        ENTRY='export PATH=$PATH:'$INSTALL_PREFIX/.bashdatacatalog
        grep -F "$ENTRY" $ENVIRONMENT_FILE || echo "$ENTRY" >> $ENVIRONMENT_FILE
        echo 'USER ACTION: bashdatacatalog is now available. Please restart your terminal.'
        break
        ;;
    [Nn])
        echo "USER ACTION: You should manually add '$INSTALL_PREFIX/.bashdatacatalog' to \$PATH in your environment set up." 
        break
        ;;
    * ) 
        echo "> Please answer Y or N."
        ;;
    esac
done

echo "Installation complete."
