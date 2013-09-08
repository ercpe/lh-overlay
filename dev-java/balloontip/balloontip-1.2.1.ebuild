# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A balloon tip component to spice up your Java Swing applications"
HOMEPAGE="https://balloontip.java.net/"
SRC_URI="https://java.net/projects/${PN}/downloads/download/${PN}_${PV}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}_${PV}/"

JAVA_SRC_DIR="src/${PN}/src/main/java"

src_prepare() {
	rm "${S}"/src/pom.xml "${S}"/src/${PN}/pom.xml "${S}"/src/${PN}-examples/pom.xml || die
}

src_compile() {
	java-pkg-simple_src_compile
	jar uf ${PN}.jar -C "${S}"/src/${PN}/src/main/resources/ . || die
}

src_install() {
	java-pkg-simple_src_install
	use examples && java-pkg_doexamples "${S}"/src/${PN}-examples/src/main/*
}
