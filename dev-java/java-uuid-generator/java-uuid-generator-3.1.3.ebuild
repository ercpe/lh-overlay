# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A library for generating all 3 types of UUIDs on Java."
HOMEPAGE="http://wiki.fasterxml.com/JugHome"
SRC_URI="https://github.com/cowtowncoder/${PN}/archive/${P}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/log4j"
RDEPEND=">=virtual/jre-1.5 ${CDEPEND}"
DEPEND=">=virtual/jdk-1.5 ${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="log4j"

S="${WORKDIR}/${PN}-${PN}-${PV}"

src_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}/build.xml" || die
	sed -i -r "s/java-uuid-generator-[0-9]+.[0-9]+.[0-9]+-SNAPSHOT/${P}/g" "${S}/build.xml" || die
}

src_install() {
	java-pkg_newjar "${S}/target/${P}.jar" ${PN}.jar
}

