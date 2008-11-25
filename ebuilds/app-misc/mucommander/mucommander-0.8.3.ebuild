# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EAPI=1

JAVA_PKG_IUSE="doc source"
#WANT_ANT_TASKS="ant-core"

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/tags/release_${PV//./_}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit
	!app-misc/mucommander-bin"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

#S="${WORKDIR}/${P}"

src_unpack(){
	subversion_src_unpack
	java-pkg_jar-from --build-only ant-core
}


src_compile(){
	cd lib/include/
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit

	cd "${S}"
	eant nightly
}


src_install() {
	insinto /usr/share/mucommander/
	newins dist/mucommander.jar mucommander.jar

	exeinto /usr/bin
	doexe "${FILESDIR}"/mucommander
}
