# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Gion"
HOMEPAGE="http://www.silvestre.com.ar/"
SRC_URI="http://www.silvestre.com.ar/icons/Gion-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( || ( x11-themes/tango-icon-theme x11-themes/gnome-icon-theme ) )"
DEPEND=""

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	dodoc Gion/{AUTHORS,README}
	rm -f Gion/{AUTHORS,COPYING,DONATE,INSTALL,README}

	insinto /usr/share/icons
	doins -r Gion || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
