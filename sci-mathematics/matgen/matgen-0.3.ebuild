# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools eutils

DESCRIPTION="command line matrix generator"
HOMEPAGE="http://matgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	epatch "${FILESDIR}"/${PV}-quote.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc TODO THANKS README NEWS BUGS ChangeLog AUTHORS
}
