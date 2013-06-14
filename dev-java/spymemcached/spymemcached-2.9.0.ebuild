# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

UPSTREAM_PN="java-memcached-client"

DESCRIPTION="A simple, asynchronous, single-threaded memcached client written in java"
HOMEPAGE="https://code.google.com/p/spymemcached/"
SRC_URI="https://github.com/dustin/${UPSTREAM_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

CDEPEND="dev-java/log4j
	dev-java/slf4j"
DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}/${UPSTREAM_PN}-${PV}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="log4j slf4j"

java_prepare() {
	epatch "${FILESDIR}/${PV}-build.xml.patch"
	rm -r "${S}/src/main/java/net/spy/memcached/spring" || die
	sed -i -e "s/no-version/${PV}/g" "${S}/build.xml" || die
}

src_install() {
	java-pkg_newjar "${S}"/build/jars/${P}.jar ${PN}.jar
}
