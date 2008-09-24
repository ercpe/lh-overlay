# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

DESCRIPTION="Dummy package to get portage overlay running"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/dummy/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net/wiki/wiki/Private_Portage_Overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"
RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup(){
	sse2=0
	ebegin "Checking SSE2 availability!"
	grep -q sasdse2 /proc/cpuinfo
	eend $? "test
	\t\t\t\t\t ***WARNING***"
	ewarn "\t\t The CPU on this hardware platform is lacking the SSE2 instruction set!"
	ewarn "\t\t Some executables of ARP/wARP ${PV} however depend on these. Take notice that"
	ewarn "\t\t part of the software will not work and consider remote job submission to the"
	ewarn "\t\t dedicated facility at EMBL-Hamburg."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	echo $(best_version dev-lang/tk)
	echo $(has_version dev-lang/tk)
	get_all_version_components $(best_version dev-lang/tk)
	mkdir -p "${D}/usr/local/bin/"
	cp dummy.sh "${D}/usr/local/bin/"
	chmod +x "${D}/usr/local/bin/dummy.sh"
}

