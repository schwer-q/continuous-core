#!/bin/sh -

PKG_NAME="toolchain"
VERSION="1.0"

NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    mv -v /tools/bin/ld /tools/bin/ld-old
    mv -v /tools/`gcc -dumpmachine`/bin/ld /tools/`gcc -dumpmachine`/bin/ld-old
    mv -v /tools/bin/ld-new /tools/bin/ld
    ln -sfv /tools/bin/ld /tools/`gcc -dumpmachine`/bin/ld

    gcc -dumpspecs | sed -e 's@/tools@@g'			\
	-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}'	\
	-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >		\
	`dirname $(gcc --print-libgcc-file-name)`/specs	
}
