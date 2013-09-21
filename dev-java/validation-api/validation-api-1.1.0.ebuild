# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source examples test"
WANT_ANT_TASKS="dev-java/testng:6"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Bean Validation (JSR-303) API"
HOMEPAGE="https://github.com/beanvalidation/beanvalidation-api/"
SRC_URI="https://github.com/beanvalidation/bean${PN}/archive/${PV}.Final.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1.1"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/testng:6
	)
	app-arch/unzip"

S="${WORKDIR}/bean${PN}-${PV}.Final"

JAVA_ANT_REWRITE_CLASSPATH="yes"

java_prepare() {
	cp -v "${FILESDIR}/${PV}-build.xml" "${S}/build.xml" || die
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	use doc && java-pkg_dojavadoc "${S}/apidocs/"
	use source && java-pkg_dosrc "${S}/src/main/java/javax"
	use examples && java-pkg_doexamples "${S}"/src/test/java/javax/validation/examples/*
}

src_test() {
	EANT_GENTOO_CLASSPATH="testng-6"
	eant test
}