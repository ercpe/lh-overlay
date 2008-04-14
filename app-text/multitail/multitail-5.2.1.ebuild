# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic

DESCRIPTION="Tail with multiple windows."
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="debug"

DEPEND="virtual/libc
	sys-libs/ncurses"

src_compile() {
	use debug && append-flags "-D_DEBUG"
	emake all || die "make failed"
}

src_install () {
	dobin multitail
	insinto /etc
	doins multitail.conf
	insinto /etc/multitail/
	doins colors-example.pl colors-example.sh convert-geoip.pl convert-simple.pl
	dodoc Changes readme.txt thanks.txt
	dohtml manual.html manual-nl.html
	doman multitail.1
}
