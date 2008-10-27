# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_PN="${PN%-bin}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com/"
SRC_URI="${HOMEPAGE}/download/${MY_P}-portable.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/jre
	>=app-arch/p7zip-4.4.3"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

S="${WORKDIR}/muCommander-${MY_PV}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/wrapper.patch
	unpack ./"${MY_PN}".jar
}

src_compile(){
	einfo "Nothing to compile"
}


src_install(){
	insinto /opt/${MY_PN}
	doins mucommander.{exe,jar}
	exeinto /opt/${MY_PN}
	doexe mucommander.sh
	dosym ../../opt/${MY_PN}/mucommander.sh /usr/bin/mucommander

	dodoc readme.txt

	newicon about.png ${MY_PN}.png
	make_desktop_entry ${MY_PN} "muCommander" ${MY_PN}
}
