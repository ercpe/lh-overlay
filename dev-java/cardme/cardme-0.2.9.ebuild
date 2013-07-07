# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java VCard library supporting the VCard 3.0 format"
HOMEPAGE="http://dma.pixel-act.com/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_GENTOO_CLASSPATH="commons-codec"
EANT_BUILD_TARGET="compile jar"
JAVA_ANT_REWRITE_CLASSPATH="yes"

S="${WORKDIR}"

src_prepare() {
	# fix upstreams build.xml 
	sed -i -e "s/\/src\///g" "${S}"/build.xml || die
	sed -i -e "s/0.2.1/${PV}/g" "${S}"/build.xml || die

	# no tests for now
	find "${S}" -name "Test*.java" -delete || die
	find "${S}" -name "*Test.java" -delete || die
	rm "${S}/info/ineighborhood/cardme/CardmeTestSuite.java" || die
}

src_install() {
	java-pkg_newjar "${S}"/lib/${P}.jar "${PN}.jar"

	use source && java-pkg_dosrc "${S}/info"
	use doc && java-pkg_dojavadoc "${S}/doc/api"
}
