#!/bin/bash
# -*- coding: UTF-8 -*-
# This is a startup file for Debian

export PLAT_NAME="`uname -a | cut -d " " -f 12`"
echo "export PLAT_NAME=\"`uname -a | cut -d " " -f 12`\"" >> $ENV_EXPORT_SCRIPT

echo "bin/${DISTRIB_ID}/install_require_packages.sh " >> $ENV_EXPORT_SCRIPT

