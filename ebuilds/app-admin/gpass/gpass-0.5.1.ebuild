# Copyright 1999-2006 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

DESCRIPTION="A password manager for GNOME."
SRC_URI="http://projects.netlab.jp/gpass/release/${P}.tar.gz"
HOMEPAGE="http://projects.netlab.jp/gpass/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"

USE_DESTDIR="1"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2.6
	app-crypt/mhash
	dev-libs/libmcrypt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf \
		$(use_enable static) \
		|| die "econf failed"

	emake LDFLAGS="-export-dynamic" || die "emake failed"
}

src_install() {
	gnome2_src_install
	dodoc AUTHORS TODO README INSTALL NEWS
}

