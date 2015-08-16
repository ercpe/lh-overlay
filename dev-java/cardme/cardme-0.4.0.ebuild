# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

JAVA_PKG_IUSE="doc source test"
WANT_ANT_TASKS="ant-junit"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java VCard library supporting the VCard 3.0 format"
HOMEPAGE="http://dma.pixel-act.com/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0.4"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	dev-java/commons-codec:0"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/junit:4 )
	${CDEPEND}
	app-arch/unzip"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="commons-codec"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/build.xml || die

	# move source and test code to the correct location
	mkdir "${S}"/src "${S}"/tests || die
	find ./ -name "*Test*.java" -exec sh -c '
		mkdir -p "$0/${1%/*}"
		mv -v "$1" "$0/$1"' "${S}"/tests {} \; || die
	mv "${S}"/net "${S}"/src || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar

	use source && java-pkg_dosrc "${S}/src/net"
	use doc && java-pkg_dojavadoc "${S}/apidocs"
}

src_test() {
	java-pkg-2_src_test
}
