# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="common"
MY_PV=${PV//./_}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="JGoodies Common Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.6"

java_prepare() {
	mkdir src && cd src &&  unzip -qq ../${P}-sources.jar || die
	find "${S}" -name '*.jar' -exec rm -v {} + || die
}

src_compile() {
	mkdir "${S}/classes" || die

	find src -name "*.java" > "${T}/src.list" || die
	ejavac -encoding ISO-8859-1 -d "${S}/classes" "@${T}/src.list"

	cd "${S}/classes" || die
	jar -cf "${S}/${PN}.jar" * || die "failed to create jar"
}

src_install() {
	java-pkg_dojar ${PN}.jar

	dodoc RELEASE-NOTES.txt README.html || die

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/com
}