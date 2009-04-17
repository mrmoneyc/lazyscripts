#!/usr/bin/env python
import os
from lazyscripts import info

def main():
    uri = "http://ftp.isu.edu.tw/pub/Linux/opensuse/distribution/"
    distro, codename = info.get_distro()
    comps = [ "oss", "non-oss" ]
    for comps in comps:

        os.system("zypper ar " + uri + codename  + "/repo/" + comps + "/ lazyscripts-" + comps )
        os.system("zypper mr -p 10 lazyscripts-" + comps )
    os.system("zypper refresh")







