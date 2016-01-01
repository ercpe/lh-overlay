# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java VCard library supporting the VCard 3.0 format"
HOMEPAGE="http://dma.pixel-act.com/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="BSD-2"
SLOT="0.2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

EANT_BUILD_TARGET="compile jar"
JAVA_ANT_REWRITE_CLASSPATH="yes"

S="${WORKDIR}"

src_prepare() {
	find "${S}" -name "*.class" -delete || die

	# move source code into the right locations..
	mkdir "${S}"/src || die
	mv "${S}"/info "${S}"/src || die

	# test code/build script is broken beyond repair
	find "${S}" -name "*Test*.java" -delete || die

	# fix version in build.xml 
	sed -i -e "s/0.2.1/${PV}/g" "${S}"/build.xml || die
}

src_install() {
	java-pkg_newjar "${S}"/lib/${P}.jar ${PN}.jar

	use source && java-pkg_dosrc "${S}/src/info"
	use doc && java-pkg_dojavadoc "${S}/doc/api"
}
