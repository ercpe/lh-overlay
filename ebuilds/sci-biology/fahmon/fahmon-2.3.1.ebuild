# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="wxGTK monitor for the folding@home client"
HOMEPAGE="http://fahmon.net/"
SRC_URI="http://fahmon.net/downloads/FahMon-2.3.1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="mirror"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/wxGTK-2.6.3"
DEPEND="${RDEPEND}"

pkg_setup() {
	if built_with_use x11-libs/wxGTK debug ; then
		die "wxGTK must be built with USE='-debug'"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/FahMon-2.3.1/src
}

src_compile() {
	cd "${WORKDIR}"/FahMon-2.3.1/
	econf
	emake
}

src_install() {
	cd "${WORKDIR}"/FahMon-2.3.1/
	emake DESTDIR="${D}" install
}