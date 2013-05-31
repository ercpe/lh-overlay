# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2

DESCRIPTION="Application launcher for GNOME"
HOMEPAGE="http://developer.imendio.com/projects/gnome-launch-box"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	gnome-base/gnome-vfs:2
	gnome-base/libgnomeui
	gnome-base/gnome-menus:0
	gnome-base/gnome-desktop:2
	gnome-extra/evolution-data-server
	gnome-base/gconf
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	# Fix tests
	cat >> po/POTFILES.in <<- EOF
	data/90-gnome-launch-box.xml.in
	src/lb-main.c
	EOF
	gnome2_src_prepare
}
