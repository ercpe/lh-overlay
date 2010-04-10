# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A simple graphical configuration tool to modify the input device hierarchy in MPX"
HOMEPAGE="http://who-t.blogspot.com/2008/07/gnome-device-setup.html"
SRC_URI="http://people.freedesktop.org/~whot/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=x11-libs/libXi-1.1.99
	>=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.4.99"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
