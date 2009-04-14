#!/bin/bash
# -*- coding: UTF-8 -*-
# This is a startup file for Debian

export PLAT_NAME="`uname -a | cut -d " " -f 12`"
echo "export PLAT_NAME=\"`uname -a | cut -d " " -f 12`\"" >> $ENV_EXPORT_SCRIPT
export SCRIPTS_REPO=$DEB_SCRIPTS_REPO
echo "SCRIPTS_REPO='${SCRIPTS_REPO}'" >> $ENV_EXPORT_SCRIPT
echo "Check for required packsges..."
if dpkg -l python-nose python-setuptools git-core &> /dev/null ; then
    echo "Require packages installed."
else
    echo "Require packages not installed."
    echo "distrib/${DISTRIB_ID}/install_require_packages.sh " >> $ENV_EXPORT_SCRIPT
fi

if python -c "import imp;imp.find_module('git')" &> /dev/null
    echo "Require module found."
else
    echo "Require module not found."
    echo "easy_install GitPython" >> $ENV_EXPORT_SCRIPT
fi
