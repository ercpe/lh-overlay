# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm"
HOMEPAGE="http://www.coyotegulch.com/products/acovea/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="unicode"
DEPEND=">app-benchmarks/acovea-5
		dev-libs/libcoyotl
		dev-libs/libevocosm
		dev-libs/expat
		>=dev-cpp/gtkmm-2.4.0
		>=sys-devel/gcc-3.4"
#        >=dev-libs/libacovea-5.1.1

src_unpack() {
	unpack ${A}
	cd "${S}"
	use unicode && epatch "${FILESDIR}"/${P}-unicode.patch
}

src_install() {
	make DESTDIR="${D}" install
	make_desktop_entry acovea-gtk Acovea-gtk \
	/usr/share/acovea-gtk/pixmaps/acovea_icon_064.png System
	dodoc ChangeLog NEWS README
}

