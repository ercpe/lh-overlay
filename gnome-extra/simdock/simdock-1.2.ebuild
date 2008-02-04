# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="a fast and customizable dockbar written in C++/wxWidgets"
HOMEPAGE="http://sourceforge.net/projects/simdock/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/wxGTK-2.8.0
		>=gnome-base/gconf-2.18.0
		>=x11-libs/libwnck-2.18.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S=${WORKDIR}/trunk

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
}