# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source"

inherit java-pkg-2

DESCRIPTION="A small Java library with one purpose: To instantiate a new object of a class."
HOMEPAGE="http://objenesis.googlecode.com/"
SRC_URI="http://objenesis.googlecode.com/files/${P}-bin.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	unzip "${S}"/${P}-sources.jar -d "${S}" || die
}

src_compile() {
	mkdir -p "${S}"/build || die
	cp -R "${S}"/META-INF build || die
	ejavac -d "${S}"/build $(find "${S}"/org -iname '*.java')

	jar -cf "${PN}.jar" -C "${S}"/build . || die
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	dodoc "${S}"/NOTICE
	use source && java-pkg_dosrc org
}