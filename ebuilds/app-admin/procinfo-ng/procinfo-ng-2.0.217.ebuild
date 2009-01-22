# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Procinfo-NG is a complete rewrite of the old system monitoring app procinfo."
HOMEPAGE="http://sourceforge.net/projects/procinfo-ng/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="sys-libs/ncurses"

RDEPEND="${DEPEND}
	!app-admin/procinfo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# removing -s flag as portage does the stripping part and add support
	# for custom LDFLAGS.
	sed -e 's:-s -lncurses:-lncurses ${LDFLAGS}:' \
		-i configure.in || die "sed configure.in failed"
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || "install failed"
}

