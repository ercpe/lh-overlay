# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE=""

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN//-bin/}-${PV//./_}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://www.mucommander.com/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.5 dev-java/java-config"
RDEPEND="${DEPEND} !app-misc/mucommander"

S="${WORKDIR}/muCommander-0_8_4" #oh, i'm sorry :)

src_unpack() {
	unpack ${A}
	cd "${S}"
	jar xf mucommander.jar icon32_24.png
}

src_compile() {
	# nothing to do
	echo ""
}

src_install() {
	java-pkg_dojar mucommander.jar

	## create a launcher
	java-pkg_dolauncher mucommander --java_args "-Djava.system.class.loader=com.mucommander.file.AbstractFileClassLoader"

	dodoc readme.txt

	newicon "${S}/icon32_24.png" "${PN}.png"
	make_desktop_entry mucommander "muCommander" ${PN}.png
}
