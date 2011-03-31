# Copyright 1999-2011 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils gnome2

DESCRIPTION="A password manager for GNOME."
SRC_URI="http://projects.netlab.jp/gpass/release/${P}.tar.gz"
HOMEPAGE="http://projects.netlab.jp/gpass/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"

USE_DESTDIR="1"

RDEPEND="
	dev-libs/glib:2
	gnome-base/gconf:2
	gnome-base/libglade:2.0
	gnome-base/libgnomeui
	x11-libs/gtk+:2
	app-crypt/mhash
	dev-libs/libmcrypt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable static)
}

src_compile() {
	emake LDFLAGS="-export-dynamic" || die "emake failed"
}

src_install() {
	gnome2_src_install
	dodoc AUTHORS TODO README INSTALL NEWS
}
