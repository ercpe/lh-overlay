# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A tool for controlling the LEDs on an Alix board"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
RESTRICT="mirror"

KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${PN}"
}

src_install() {
	cd "${PN}" || die
	dosbin "usr/sbin/alix-leds.py" || die
	doconfd "etc/conf.d/alix-leds" || die
	doinitd "etc/init.d/alix-leds" || die
}
