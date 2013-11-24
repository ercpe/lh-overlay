# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.slf4j.org/dist/${P/-api/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

S="${WORKDIR}/${P/-api/}/${PN}"

java_prepare() {
	cp -v "${FILESDIR}"/${PV}-build.xml build.xml || die
	find "${WORKDIR}" -iname '*.jar' -delete
}

src_install() {
	java-pkg_newjar target/${P}.jar "${PN}.jar"

	use doc && java-pkg_dojavadoc "${S}"/apidocs
	use source && java-pkg_dosrc src/main/java/org
}
