# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs eutils

DESCRIPTION="CLI to monitors and displays squid logs in a nice fashion"
HOMEPAGE="http://www.rillion.net/squidview/"
SRC_URI="http://www.rillion.net/squidview/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

src_prepare() {
	epatch "${FILESDIR}/00_gentoo_locations.patch"
}

src_install(){
	dobin squidview
	dodoc AUTHORS BUGS ChangeLog HOWTO
}
