# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A set of useful tools to make your (gentoo) admin life easier"
HOMEPAGE="http://www.j-schmitz.net/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${PF}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="AS-IS"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT="mirror"

pkg_setup() {
	ewarn "This package contains potentially dangerous scripts. Use it with care!"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_install() {
	exeinto /usr/sbin
	
	for x in autounmask regen-meta-flat rebuild-all; do
		doexe "$x"
	done 
}
