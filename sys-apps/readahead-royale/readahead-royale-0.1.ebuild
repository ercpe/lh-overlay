# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="royale readahead after http://forums.gentoo.org/viewtopic-t-478491-start-0.html"
HOMEPAGE="http://forums.gentoo.org/viewtopic-t-478491.html"
SRC_URI="https://mirror.not-your-server.de/overlays/last-hope/sys-apps/temerge/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sys-process/lsof
	sys-apps/gawk"
DEPEND=""

src_install() {
	insinto /etc/
	doins readahead-royale.conf
	doinitd readahead-royale
	dosbin uniquer sample-init-process
	touch "${D}"/forcesampler
}

pkg_postinst(){
	elog
	einfo "Remember to add readahead-royale to the default runlevel"
	einfo "rc-update add readahead-royale default"
	elog
	einfo "To create a new list just"
	einfo "touch /forcesampler"
}
