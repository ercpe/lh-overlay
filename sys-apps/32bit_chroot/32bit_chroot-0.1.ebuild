# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Setup a 32bit chroot as service"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="https://mirror.not-your-server.de/overlays/last-hope/sys-apps/temerge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	doinitd gentoo_32bit
	doconfd gentoo_32bit.conf
}

pkg_postinst(){
	elog
	einfo "Remember to add 32bit_chroot to the default runlevel"
	einfo "rc-update add 32bit_chroot default"
	elog
	einfo "Use this to chroot"
	einfo "linux32 chroot CHROOTDIR /bin/bash"
	elog
}
