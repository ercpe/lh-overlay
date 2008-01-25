# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Dummy package to get portage overlay running"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/dummy/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}


src_install() {
	ls -lah .
	mkdir -p "${D}/usr/local/bin/"
	cp dummy.sh "${D}/usr/local/bin/"
	chmod +x "${D}/usr/local/bin/dummy.sh"
}

