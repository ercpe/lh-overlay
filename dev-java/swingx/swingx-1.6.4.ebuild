# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A collection of powerful, useful, and just plain fun Swing components."
HOMEPAGE="https://swingx.java.net/"
SRC_URI="https://java.net/downloads/${PN}/releases/${PN}-all-${PV}-sources.jar
	https://java.net/downloads/${PN}/releases/${PN}-mavensupport-${PV}-sources.jar"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/metainf-services"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="metainf-services"

S="${WORKDIR}"

src_unpack() {
	mkdir "src" && cd "src" && unpack ${A} && cd "${S}" || die
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar
}
