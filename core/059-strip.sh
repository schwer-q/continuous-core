#!/bin/sh -

PKG_NAME="strip"
PKG_VERSION="1.0"
NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    if test -z "$TOOLCHAIN_BASH"; then
	export TOOLCHAIN_BASH="YES"
	exec /tools/bin/bash --login ./build.sh ./059-strip.sh
    fi
    
    /tools/bin/find /bin -type		f -exec /tools/bin/strip --strip-debug '{}' ';' || true
    /tools/bin/find /lib -type		f -exec /tools/bin/strip --strip-debug '{}' ';' || true
    /tools/bin/find /sbin -type		f -exec /tools/bin/strip --strip-debug '{}' ';' || true
    /tools/bin/find /usr/bin -type	f -exec /tools/bin/strip --strip-debug '{}' ';' || true
    /tools/bin/find /usr/lib -type	f -exec /tools/bin/strip --strip-debug '{}' ';' || true
    /tools/bin/find /usr/sbin -type	f -exec /tools/bin/strip --strip-debug '{}' ';' || true
}
