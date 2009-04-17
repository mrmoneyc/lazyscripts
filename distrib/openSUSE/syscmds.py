#!/usr/bin/env python
"""
Here store the command which only in openSUSE
"""

detect_pack = "rpm -q "
install_cmd = "zypper -l --yes install "
remove_cmd = "zypper --yes remove "
network_config = ""
repo_config = ""


if __name__ == "__main__" :
    print detect_pack
    print remove_cmd
    print install_cmd
    print network_config
    print repo_config

