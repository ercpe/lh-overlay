# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libroadnav/libroadnav-0.16.ebuild,v 1.1 2006/11/27 22:43:30 kloeri Exp $

DESCRIPTION="Ohcount is a source code line counter"
HOMEPAGE="http://labs.ohloh.net/ohcount"
RESTRICT="nomirror"
SRC_URI="http://labs.ohloh.net/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${P}"

DEPEND="dev-ruby/rake"

src_compile() {
	cd ${S}
	rake
}

src_install() {
	cd ${S}
	rake install
	exeinto /usr/bin
	doexe ${S}/bin/ohcount
	dodoc ${S}/README
}
