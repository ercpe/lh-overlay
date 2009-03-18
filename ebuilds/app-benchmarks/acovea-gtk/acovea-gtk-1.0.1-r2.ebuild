# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm GUI"
HOMEPAGE="http://www.coyotegulch.com/products/acovea/"
SRC_URI="http://www.coyotegulch.com/distfiles/${P}.tar.gz"
LICENSE="GPL-2"
RESTRICT="primaryuri"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="unicode"
RDEPEND="${DEPEND}"
DEPEND=">app-benchmarks/acovea-5
	dev-cpp/gtkmm:2.4"

src_prepare() {
	use unicode && epatch "${FILESDIR}"/${P}-unicode.patch
	epatch "${FILESDIR}"/${P}-libsigc.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
	make_desktop_entry acovea-gtk Acovea-gtk \
	/usr/share/acovea-gtk/pixmaps/acovea_icon_064.png System
	dodoc ChangeLog NEWS README
}
