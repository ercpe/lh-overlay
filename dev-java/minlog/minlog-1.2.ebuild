# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Minimal overhead Java logging"
HOMEPAGE="https://code.google.com/p/minlog/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${PN}/"

JAVA_ANT_REWRITE_CLASSPATH="yes"

src_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar
	use source && java-pkg_dosrc "${S}"/src/*
	use doc && java-pkg_dojavadoc "${S}"/apidocs
}
