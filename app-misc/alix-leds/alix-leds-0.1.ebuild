# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A tool for controlling the LEDs on an Alix board"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/${PN}

src_install() {
	dosbin "usr/sbin/alix-leds.py"
	doconfd "etc/conf.d/alix-leds"
	doinitd "etc/init.d/alix-leds"
}
