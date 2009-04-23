#!/bin/bash
export DISTRIB_CODENAME=n/a
export DISTRIB_VERSION=11.1
export DISTRIB_ID=openSUSE
export PLAT_NAME="i386"
export WIN_MGR="Gnome"
bin/openSUSE/install_require_packages.sh
REPO_URL=(git://github.com/billy3321/lazyscripts_pool_opensuse.git)
export REPO_URL
export REPO_NUM=1
./lzs list build git://github.com/billy3321/lazyscripts_pool_opensuse.git
export REPO_DIR
export REAL_USER="mrmoneyc"
export REAL_HOME="/home/mrmoneyc"
export WGET="wget --tries=2 --timeout=120 -c"

./lzs $@
