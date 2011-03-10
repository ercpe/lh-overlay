# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils qt4-r2

DESCRIPTION="Utility designed to help you forget about your start menu, the icons on your desktop"
HOMEPAGE="http://www.launchy.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="gnome"

DEPEND="
	dev-libs/boost
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	gnome? ( gnome-base/libgnome )"
RDEPEND="x11-misc/xdg-utils"

DOCS="Readme.pdf Readme.doc"

src_install() {
	qt4-r2_src_install
	newdoc readme.txt Changelog.txt || die
	newdoc readme.lyx Changelog.lyx || die
}
