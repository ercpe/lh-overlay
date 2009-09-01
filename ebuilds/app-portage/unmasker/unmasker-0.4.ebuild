# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="This is Gentoo packages automatic unmasker"
HOMEPAGE="http://devel0per-soft.blogspot.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tbz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="app-portage/eix"

src_install() {
	dobin usr/bin/unmasker || die
	dodoc README AUTHORS || die
	insinto /etc
	doins etc/unmasker.conf || die
}

pkg_postinst() {
	ewarn "Please be sure what your eix data base is not out of date."
	elog "Your can customize settings permanently using /etc/unmasker.conf"
}
