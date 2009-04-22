#!/bin/bash
# -*- coding: UTF-8 -*-
# This is a startup file for Lazyscripts

# the function use to get distribution name and version or codename.
function get_distro_info () {
if which lsb_release &> /dev/null ; then
    export DISTRIB_ID=`lsb_release -is`
    export DISTRIB_CODENAME=`lsb_release -cs`
    export DISTRIB_VERSION=`lsb_release -rs`
    if [ "$DISTRIB_ID" == "SUSE LINUX" ] ; then
        case "$DISTRIB_VERSION" in
            "11.1"|"11.0")
                export DISTRIB_ID="openSUSE"
            ;;
        esac
    fi
    echo "export DISTRIB_CODENAME=`lsb_release -cs`" >> "$ENV_EXPORT_SCRIPT"
    echo "export DISTRIB_VERSION=`lsb_release -rs`" >> "$ENV_EXPORT_SCRIPT"
    echo "export DISTRIB_ID=`lsb_release -is`" >> "$ENV_EXPORT_SCRIPT"

elif grep "Fedora" /etc/issue ; then
    # Fedora does not install lsb (redhat-lsb) in default setting so detect /etc/issue or let user choice...
    export DISTRIB_ID="Fedora"
    echo "export DISTRIB_CODENAME=\"Fedora\"" >> "$ENV_EXPORT_SCRIPT"
    export DISTRIB_CODENAME=""
    export DISTRIB_VERSION=""
else
# Let user choice by them self.
    echo "Sorry, Lazyscripts can't distinguish your Linux distribution."
    echo "Please choice your distribution in the list."
    zenity --info --text "Sorry, Lazyscripts can't distinguish your Linux distribution. Please choice your distribution in the list by your self.\n      \nNote: If you can't find your Linux distribution in the list, It means Lazyscripts not support your distribution. Please contact develpers. http://code.google.com/p/lazyscripts/"
    DISTRIB_ID=`zenity --list --title="Choice your linux distribution" --radiolist --column "" --column "Linux Distribution" FALSE Fedora FALSE others`
    export DISTRIB_ID=${DISTRIB_ID}
    echo "export DISTRIB_ID=${DISTRIB_ID}" >> "$ENV_EXPORT_SCRIPT"
fi
}

function init_export_script () {
    mkdir -p tmp
    export ENV_EXPORT_SCRIPT="tmp/env-export.sh"
    if [ -f ${ENV_EXPORT_SCRIPT} ];then
        rm $ENV_EXPORT_SCRIPT
    fi

    touch "$ENV_EXPORT_SCRIPT"
    chmod a+x "$ENV_EXPORT_SCRIPT"
    echo "#!/bin/bash" > "$ENV_EXPORT_SCRIPT"
}

# the function is use to show a repository list if has more then one repository.
# store in $REPO_URL as array and $REPO_NUM as number.
function choice_repo () {
    DISTRIB_NAME="$DISTRIB_ID"
    AVAILABLE_REPO=($(cat conf/repository.conf  | grep "${DISTRIB_NAME}" | cut -d " " -f 1 | grep "^[git].*[git]$"))
    if [ ${#AVAILABLE_REPO[@]} -eq 1 ];then
        USE_REPO=(${AVAILABLE_REPO})
        REPO_URL=(${AVAILABLE_REPO})
    else
        SHOW_REPO=$(for uri in ${AVAILABLE_REPO[*]} ; do echo -n "FALSE $uri " ; done)
        USE_REPO=`zenity --list --title="Choice Scripts Repository You Want to Use" --radiolist --column "" --column "Repository URL" ${SHOW_REPO}`
        REPO_URL=(${USE_REPO/|/ })
    fi
    export REPO_URL
    export REPO_NUM=${#REPO_URL[@]}
    echo "REPO_URL=(${USE_REPO/|/ })" >> $ENV_EXPORT_SCRIPT
    echo "export REPO_URL" >> $ENV_EXPORT_SCRIPT
    echo "export REPO_NUM=${#REPO_URL[@]}" >> $ENV_EXPORT_SCRIPT
    for ((num=0;num<${REPO_NUM};num=$num+1)); do 
        echo "REPO_DIR[$num]=\"./scriptspoll/\`./lzs repo sign ${REPO_URL[${num}]}\`\"" >> $ENV_EXPORT_SCRIPT 
        echo "git clone ${REPO_URL[$num]} \${REPO_DIR[$num]}" >> $ENV_EXPORT_SCRIPT
        echo "./lzs list build ${REPO_URL[$num]}" >> $ENV_EXPORT_SCRIPT
    done
    echo "export REPO_DIR" >> $ENV_EXPORT_SCRIPT
}

# some workaround
DIR=`dirname $0`
cd "$DIR"

init_export_script

get_distro_info

case "$DISTRIB_ID" in
    "Ubuntu"|"Debian"|"openSUSE"|"Fedora")
    source bin/${DISTRIB_ID}/startup.sh
    ;;
    *)
    #else
    zenity --info --text "Sorry, Lazyscripts not support your Distribution. The program will exit"
    rm ${ENV_EXPORT_SCRIPT}
    exit
    ;;
esac


# get scripts from github
# REPO_URL=`cat conf/repository.conf`
choice_repo
REPO_DIR="./scriptspoll/`./lzs repo sign $REPO_URL`"
git clone "$REPO_URL" "$REPO_DIR"

# check the path of desktop dir
XDG_USER_DIRS=~/.config/user-dirs.dirs
if [ -f "$XDG_USER_DIRS" ]; then
    . ~/.config/user-dirs.dirs
fi

if [ -z "$XDG_DESKTOP_DIR" ]; then
    export DESKTOP_DIR=$HOME/Desktop

else
    export DESKTOP_DIR=$XDG_DESKTOP_DIR
fi
                                        
# Ensure there is a desktop dir, if this doesn't exist, that's a bug of ubuntu.
if [ ! -e "$DESKTOP_DIR" ]; then
    mkdir -p  "$DESKTOP_DIR"
fi
                                                        
# symlink desktop dir to ~/Desktop for compatibility
if [ "$DESKTOP_DIR" != "$HOME/Desktop"  -a  ! -e "$HOME/Desktop" ]; then
    ln -s "$DESKTOP_DIR" "$HOME/Desktop"
fi
                                                                            
# Preserve the user name
export REAL_USER="$USER"
export REAL_HOME="$HOME"
echo "export REAL_USER=\"$USER\"" >> $ENV_EXPORT_SCRIPT
echo "export REAL_HOME=\"$HOME\"" >> $ENV_EXPORT_SCRIPT
                                                                   
# wget command used to download files
export WGET="wget --tries=2 --timeout=120 -c"
echo "export WGET=\"wget --tries=2 --timeout=120 -c\"" >> $ENV_EXPORT_SCRIPT

# a blank line
echo >> $ENV_EXPORT_SCRIPT

# FIXME: export-env just using to pass envirnoment variables, please don't use any command in it.
echo './lzs $@'  >> $ENV_EXPORT_SCRIPT
