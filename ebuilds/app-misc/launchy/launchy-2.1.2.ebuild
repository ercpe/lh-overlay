# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Launchy is a utility designed to help you forget about your start menu, the icons on your desktop"
HOMEPAGE="http://www.launchy.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
RESTRICT="mirror"

KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="gnome"

DEPEND="dev-libs/boost
				>=x11-libs/qt-4
				gnome? ( gnome-base/libgnome )"
RDEPEND="x11-misc/xdg-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-makefile.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	newdoc readme.txt Changelog.txt
	newdoc readme.lyx Changelog.lyx
	dodoc Readme.pdf Readme.doc
}
