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
cat >> ${ENV_EXPORT_SCRIPT} << EOF
if [ -f "/var/run/yum.pid" ]; then
    echo "Remove the lock file"
    kill `cat /var/run/yum.pid`
    rm -f /var/run/yum.pid
fi  
EOF

if rpm -q python-nose python-setuptools-devel git-core redhat-lsb ; then
    echo "Require packages installed."
else
    echo "Require packages not installed."
    echo "distrib/${DISTRIB_ID}/install_require_packages.sh" >> $ENV_EXPORT_SCRIPT
fi

if python -c "import imp;imp.find_module('git')" &> /dev/null
    echo "Require module found."
else
    echo "Require module not found."
    echo "easy_install GitPython" >> $ENV_EXPORT_SCRIPT
fi
