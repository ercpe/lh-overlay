# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Setup a 32bit chroot as service"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="https://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_install() {
	doinitd gentoo_32bit
	doconfd gentoo_32bit.conf
}

pkg_postinst(){
	echo
	elog "Remember to add 32bit_chroot to the default runlevel"
	elog "rc-update add 32bit_chroot default"
	echo
	elog "Use this to chroot"
	elog "linux32 chroot CHROOTDIR /bin/bash"
	echo
}
