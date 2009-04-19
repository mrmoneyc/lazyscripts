#!/bin/bash
# -*- coding: UTF-8 -*-
# This is a startup file for Fedora

export PLAT_NAME="`uname -i`"
echo "export PLAT_NAME=\"`uname -i`\"" >> $ENV_EXPORT_SCRIPT
    
if [ -z "$DISTRIB_VERSION" ];then
    DISTRIB_VERSION=`zenity --list --title="Choice your linux distribution version" --radiolist --column "" --column "Linux Distribution Version" FALSE "Fedora 10"`
    case $DISTRIB_VERSION in
        "Fedora 10")
        export DISTRIB_VERSION="10"
        ;;
    esac
    echo "export DISTRIB_VERSION=${DISTRIB_VERSION}" >> $ENV_EXPORT_SCRIPT
fi
WIN_MGR=`zenity --list --title="Choice your window manager" --radiolist --column "" --column "Linux Distribution Version" FALSE "Gnome" FALSE "KDE"`
export WIN_MGR=${WIN_MGR}
echo "export WIN_MGR=${WIN_MGR}" >> $ENV_EXPORT_SCRIPT

echo "distrib/${DISTRIB_ID}/install_require_packages.sh" >> $ENV_EXPORT_SCRIPT