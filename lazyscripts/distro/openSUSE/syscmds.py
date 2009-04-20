#!/usr/bin/env python
"""
Here store the command which only in openSUSE
"""
import os

detect_pack = "rpm -q "
install_cmd = "zypper -n install "
remove_cmd = "zypper -n remove "

if os.environ['WIN_MGR'] == 'Gnome':
    network_config = "/usr/bin/nm-connection-editor"
elif  os.environ['WIN_MGR'] == 'KDE':
    network_config = ""

repo_config = "yast2 repositories"


if __name__ == "__main__" :
    print detect_pack
    print remove_cmd
    print install_cmd
    print network_config
    print repo_config

