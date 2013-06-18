# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source examples"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A low level toolset of Java components focused on HTTP and associated protocols"
HOMEPAGE="http://hc.apache.org/index.html"
SRC_URI="mirror://apache/${PN/-//http}/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

CDEPEND="dev-java/commons-logging
	dev-java/commons-codec
	dev-java/httpcomponents-core
"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_TARGET="package"
EANT_GENTOO_CLASSPATH="commons-logging commons-codec httpcomponents-core"

src_prepare() {
	cp "${FILESDIR}/maven-build.xml" "${S}/build.xml" || die
	for x in httpclient httpmime; do
		cp "${FILESDIR}/${x}-build.xml" "${S}"/${x}/build.xml || die
	done

	# fluent-hc and httpclient-cache depends on spymemcached and >=ehcache-2.7
	# disable it for now
	sed -i -e 's/.*httpclient-cache.*//g' "${S}/build.xml" || die
	sed -i -e 's/.*fluent-hc.*//g' "${S}/build.xml" || die
}

src_install() {
	for mod in httpclient httpmime; do
		java-pkg_newjar "${S}/${mod}/target/${mod}-${PV}.jar" ${mod}.jar
	done

	use source && java-pkg_dosrc "${S}"/{httpclient,httpmime}/src/main/java/
	use examples && java-pkg_doexamples "${S}"/{httpclient,httpmime}/src/examples/
}
