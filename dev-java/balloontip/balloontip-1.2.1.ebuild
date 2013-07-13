# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A balloon tip component to spice up your Java Swing applications."
HOMEPAGE="https://balloontip.java.net/"
SRC_URI="https://java.net/projects/${PN}/downloads/download/${PN}_${PV}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}_${PV}/src/${PN}"

src_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar
	use source && java-pkg_dosrc "${S}"/src/main/java/*
	use doc && java-pkg_dojavadoc "${S}"/apidocs

	dodoc "${WORKDIR}"/${PN}_${PV}/README.txt
}
