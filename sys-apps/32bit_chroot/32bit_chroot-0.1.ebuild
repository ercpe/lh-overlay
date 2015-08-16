# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Setup a 32bit chroot as service"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/sys-apps/32bit_chroot/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"

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
