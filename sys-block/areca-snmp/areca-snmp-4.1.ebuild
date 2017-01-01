# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

UPSTREAM_TAG="110113"

MY_PN="linuxsnmp"
MY_P="${MY_PN}_V${PV}_${UPSTREAM_TAG}"

DESCRIPTION="SNMP agent for areca RAID controller"
HOMEPAGE="http://www.areca.com.tw/support/s_linux/linux.htm"
SRC_URI="http://www.areca.us/support/s_linux/snmp/${MY_P}.zip -> ${P}.zip"

SLOT="0"
LICENSE="Areca"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="net-analyzer/net-snmp"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-linking.patch )

QA_PREBUILT=( opt/${PN}/* )

src_prepare() {
	epatch "${PATCHES[@]}"
	append-cflags -Dlinux
}

src_compile() {
	emake \
		CFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS} -Wl,-R -Wl,${EPREFIX}/opt/${PN}" \
		CC=$(tc-getCXX) \
		LIBTOOL=libtool \
		LIB_CFLAGS="-I${EPREFIX}/usr/include/net-snmp/agent/" \
		subagent64
}

src_install() {
	exeinto /opt/${PN}
	doexe linux/$(usex amd64 x86-64 "")$(usex x86 i386 "")/*so
	dobin arecamib
}
