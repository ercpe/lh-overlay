# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Fast, efficient Java serialization and cloning"
HOMEPAGE="https://code.google.com/p/kryo/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/objenesis
	dev-java/reflectasm
	dev-java/minlog"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${P}/java"

EANT_GENTOO_CLASSPATH="objenesis
	reflectasm
	minlog"
JAVA_ANT_REWRITE_CLASSPATH="yes"

src_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
}

src_install() {
	# USE DOC ETC
	java-pkg_dojar "${S}"/dist/${PN}.jar
}
