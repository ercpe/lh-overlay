# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.slf4j.org/dist/${P/-simple/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="~dev-java/slf4j-api-${PV}:0"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"

S="${WORKDIR}/${P/-simple/}"

EANT_GENTOO_CLASSPATH="slf4j-api"

S="${WORKDIR}/${P/-simple/}"

java_prepare() {
	cp -v "${FILESDIR}"/${PV}-build.xml build.xml || die

	# for ecj-3.5
	java-ant_rewrite-bootclasspath auto

	cd "${S}"
	rm *.jar integration/lib/*.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc "${S}"/${PN}/src/main/java/org
}
