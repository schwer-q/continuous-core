#!/bin/sh -

PKG_NAME="setup"
PKG_VERSION="1.0"
NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    mkdir -pv		\
	/bin		\
	/boot		\
	/etc		\
	/etc/sysconfig	\
	/lib		\
	/usr		\
	/usr/bin	\
	/usr/include	\
	/usr/lib	\
	/var		\
	/var/log

    case `uname -m` in
	x86_64) ln -sfv lib /lib64 && ln -sfv lib /usr/lib64 ;;
    esac

    /tools/bin/install -dv -m 0750 /root
    /tools/bin/install -dv -m 1777 /tmp /var/tmp

    ln -sfv /tools/bin/bash	/bin
    ln -sfv /tools/bin/cat	/bin
    ln -sfv /tools/bin/echo	/bin
    ln -sfv /tools/bin/pwd	/bin
    ln -sfv /tools/bin/stty	/bin
    ln -sfv bash		/bin/sh

    ln -sfv /tools/bin/perl /usr/bin

    ln -sfv /tools/lib/libgcc_s.so	/usr/lib
    ln -sfv /tools/lib/libgcc_s.so.1	/usr/lib
    ln -sfv /tools/lib/libstdc++.so	/usr/lib
    ln -sfv /tools/lib/libstdc++.so.6	/usr/lib

    sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la

    ln -sfv /proc/self/mounts /etc/mtab

    tar -cvf - -C $PKG_FILES . | tar -xf - -C $DESTDIR

    touch			\
	/var/log/btmp		\
	/var/log/lastlog	\
	/var/log/wtmp

    chgrp -v utmp /var/log/lastlog
    chmod -v 644  /var/log/lastlog
    chmod -v 600  /var/log/btmp
}
