# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java VCard library supporting the VCard 3.0 format"
HOMEPAGE="http://dma.pixel-act.com/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/commons-codec"
RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_GENTOO_CLASSPATH="commons-codec"
JAVA_ANT_REWRITE_CLASSPATH="yes"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/build.xml || die

	find "${S}" -name "Test*.java" -delete || die
	find "${S}" -name "*Test.java" -delete || die
	rm "${S}/net/sourceforge/cardme/CardmeTestSuite.java" || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar

	use source && java-pkg_dosrc "${S}/net"
	use doc && java-pkg_dojavadoc "${S}/apidocs"
}
