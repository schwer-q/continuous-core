#!/bin/sh -

NAME="setup-sysvinit"
VERSION="1.0"
NO_UNPACK="yes"
NO_BUILD="yes"
NO_CLEAN="yes"

install_() {
    cat > /etc/inittab << "EOF"
# Begin /etc/inittab

id:3:initdefault:

si::sysinit:/etc/rc.d/init.d/rc S

l0:0:wait:/etc/rc.d/init.d/rc 0
l0:S1:wait:/etc/rc.d/init.d/rc 1
l0:2:wait:/etc/rc.d/init.d/rc 2
l0:3:wait:/etc/rc.d/init.d/rc 3
l0:4:wait:/etc/rc.d/init.d/rc 4
l0:5:wait:/etc/rc.d/init.d/rc 5
l0:6:wait:/etc/rc.d/init.d/rc 6

ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

su:S016:once:/sbin/sulogin

1:2345:respawn:/sbin/agetty --noclear tty1 9600
2:2345:respawn:/sbin/agetty tty2 9600
3:2345:respawn:/sbin/agetty tty3 9600
4:2345:respawn:/sbin/agetty tty4 9600
5:2345:respawn:/sbin/agetty tty5 9600
6:2345:respawn:/sbin/agetty tty6 9600

#End /etc/inittab
EOF
}
