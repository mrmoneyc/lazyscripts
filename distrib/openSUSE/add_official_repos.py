#!/usr/bin/env python
import os
from lazyscripts import get_version

def main():
    distro, codename = get_version()
    comps = [ "oss", "non-oss" ]
    for comps in comps:

        os.system("zypper ar http://ftp.twaren.net/Linux/OpenSuSE/distribution/" + codename  + "/repo/" + comps + "/ lazyscripts-" + comps )
        os.system("zypper mr -p 10 lazyscripts-" + comps )
    os.system("zypper refresh")







