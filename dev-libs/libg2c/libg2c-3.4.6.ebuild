# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="Library needed for GNU Fortran 77 applications linked against the shared library."
HOMEPAGE="http://packages.debian/pool/main/g.org/lenny/libg2c0"
SRC_URI="
	x86? ( mirror://debian/pool/main/g/gcc-3.4/libg2c0_3.4.6-9_i386.deb )
	amd64? ( mirror://debian/pool/main/g/gcc-3.4/libg2c0_3.4.6-9_amd64.deb )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/dpkg"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	unpack ../work/data.tar.gz
}

src_install() {
	dolib.so usr/lib*/* || die
}
