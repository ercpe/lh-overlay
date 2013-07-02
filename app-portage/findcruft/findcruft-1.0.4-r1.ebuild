# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Yet another script to find obsolete files"
HOMEPAGE="http://forums.gentoo.org/viewtopic.php?t=254197"
SRC_URI="http://user.cs.tu-berlin.de/~sean/${P}.tar.bz2 http://ifp.loeber1.de/findcruft-config-20050807.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"

src_prepare() {
	sed -i "s#/usr/local#/usr#" "${WORKDIR}"/bin/findcruft || die
}

src_install() {
	insinto /usr/$(get_libdir)
	doins findcruft
	insinto /usr
	dobin "${WORKDIR}"/bin/findcruft
}

pkg_postinst() {
	einfo "Please check the files findcruft reports as cruft carefully"
	einfo "before deleting them! There may be false positives!"
}
