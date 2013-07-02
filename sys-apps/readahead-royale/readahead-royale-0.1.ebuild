# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="royale readahead after http://forums.gentoo.org/viewtopic-t-478491-start-0.html"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/sys-apps/readahead-royale/${P}.tar.bz2"
HOMEPAGE="http://forums.gentoo.org/viewtopic-t-478491.html"

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
