#!/bin/bash
# -*- coding: UTF-8 -*-
# This is startup file for openSUSE

export PLAT_NAME="`uname -i`"
echo "export PLAT_NAME=\"`uname -i`\"" >> $ENV_EXPORT_SCRIPT
export SCRIPTS_REPO=$SUSE_SCRIPTS_REPO
echo "SCRIPTS_REPO='${SCRIPTS_REPO}'" >> $ENV_EXPORT_SCRIPT
case $WINDOWMANAGER in
    '/usr/bin/gnome')
    export WIN_MGR='Gnome'
    echo "export WIN_MGR=\"Gnome\"" >> $ENV_EXPORT_SCRIPT
    ;;
    '/usr/bin/startkde')
    export WIN_MGR='KDE'
    echo "export WIN_MGR=\"KDE\"" >> $ENV_EXPORT_SCRIPT
    ;;
    *)
    echo "Lazysciprs can't identified your window manager"
    export WIN_MGR=''
    echo "export WIN_MGR=\"\"" >> $ENV_EXPORT_SCRIPT
    ;;
esac

cat >> $ENV_EXPORT_SCRIPT << EOF
if pgrep packagekitd ; then 
    killall packagekitd 
fi
EOF

if rpm -q python-nose python-setuptools git-core &> /dev/null ; then 
    echo "Require packages installed."
else
    echo "Require packages not installed."
    echo "distrib/${DISTRIB_ID}/install_require_packages.sh" >> $ENV_EXPORT_SCRIPT
fi

if python -c "import imp;imp.find_module('git')" &> /dev/null ; then
    echo "Require module found."
else
    echo "Require module not found."
    case $PLAT_NAME in
        i386)
        echo "easy_install -d /usr/lib/python2.6/site-packages GitPython" >> $ENV_EXPORT_SCRIPT
        ;;
        x86_64)
        echo "easy_install -d /usr/lib64/python2.6/site-packages GitPython" >> $ENV_EXPORT_SCRIPT
        ;;
        *)
        echo "sorry, not support $PLAT_NAME"
    esac
fi

