# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="Library needed for GNU Fortran 77 applications linked against the shared library."
HOMEPAGE="http://packages.debian.org/etch/libg2c0"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/g/gcc-3.4/libg2c0_3.4.6-9_i386.deb"

LICENSE=""

SLOT="0"
KEYWORDS="-* ~x86"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/dpkg"

src_unpack() {
	unpack ${A}

	unpack ../work/data.tar.gz
}

src_install() {
	insinto /usr/lib/
	doins usr/lib/*

	dosym libg2c.so.0 /usr/lib/libg2c.so
}
