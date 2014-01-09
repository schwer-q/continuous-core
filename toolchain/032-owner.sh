#!/bin/sh -

NAME="owner"
VERSION="1.0"
NO_BUILD="yes"
NO_CLEAN="yes"
NO_UNPACK="yes"

install_() {
    chown -R root:root ${LFS}/tools
}
