# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit

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

#src_prepare() {
#	epatch "${FILESDIR}"/${PN}-4.3.3-install.patch
#	eautoreconf
#}

S=${WORKDIR}/${PN}

src_prepare() {
	# Change assets path
	sed -i 's/assets\//\/usr\/share\/skipfish\/assets\//g' report.c skipfish.c || die "sed failed"
}

src_install() {
	dobin skipfish

	insinto /usr/share/${PN}/dictionaries
	doins dictionaries/*
	insinto /usr/share/${PN}/assets
	doins assets/*

	dodoc README ChangeLog
}

pkg_postinst() {
	echo
	elog "See README-FIRST in /usr/share/skipfish/dictionaries/ to pick a dictionary and use with -W option:"
	elog " skipfish -W /usr/share/skipfish/dictionaries/<dictionary_name>"
	echo
}
