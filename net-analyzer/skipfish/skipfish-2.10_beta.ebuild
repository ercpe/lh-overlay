# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs

MY_PV=${PV/_beta/b}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Web application security scanner"
HOMEPAGE="http://code.google.com/p/skipfish/"
SRC_URI="http://skipfish.googlecode.com/files/${MY_P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-dns/libidn"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Change assets path
	sed \
		-e 's/assets\//\/usr\/share\/skipfish\/assets\//g' \
		-i src/{report,skipfish}.c || die "sed failed"

	sed \
		-e "s: -g : :g" \
		-e "s: -ggdb : :g" \
		-e "s:-O3:${CFLAGS}:g" \
		-i Makefile || die

	tc-export CC
}

src_install() {
	dobin ${PN}

	insinto /usr/share/${PN}/
	doins -r dictionaries assets

	dodoc README ChangeLog
}

pkg_postinst() {
	echo
	elog "See README-FIRST in /usr/share/skipfish/dictionaries/ to pick a dictionary and use with -W option:"
	elog " skipfish -W /usr/share/skipfish/dictionaries/<dictionary_name>"
	echo
}
