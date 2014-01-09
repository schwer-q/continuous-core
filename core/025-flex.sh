#!/bin/sh -

NAME="flex"
VERSION="2.5.37"
EXT="tar.bz2"

build() {
    sed -i -e '/test-bison/d' tests/Makefile.in

    ./configure		\
	--prefix=/usr	\
	--docdir=/usr/share/doc/$PKG_SOURCES

    make
}

install_() {
    make install

    ln -sfv libfl.a /usr/lib/libl.a

    cat > /usr/bin/lex << "EOF"
#!/bin/sh
# Begin /usr/bin/lex

exec /usr/bin/flex -l "$@"

# End /usr/bin/lex
EOF

    chmod -v 755 /usr/bin/lex
}
