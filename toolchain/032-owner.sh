#!/bin/sh -

NAME="owner"
VERSION="1.0"
NO_UNPACK="yes"

build() {
    :
}

install() {
    chown -R root:root ${LFS}/tools
}

clean() {
    :
}
