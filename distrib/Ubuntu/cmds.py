#!/usr/bin/env python
"""
Here store the command which only in Ubuntu
"""

detect_pack = "dpkg -l "
install_cmd = "apt-get -y --force-yes install "
remove_cmd = "apt-get -y --force-yes --purge remove "
network_config = "/usr/bin/nm-connection-editor"
repo_config = "software-properties-gtk"


if __name__ == "__main__" :
    print detect_pack
    print remove_cmd
    print install_cmd
    print network_config
    print repo_cofig

