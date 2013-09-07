# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="High performance Java reflection"
HOMEPAGE="https://code.google.com/p/reflectasm/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/asm:3"

DEPEND="${CDEPEND}
	test? ( dev-java/junit:4 )
	>=virtual/jdk-1.5"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${P}/java"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="asm-3"
EANT_TEST_ANT_TASKS="ant-junit"

S="${WORKDIR}/${P}/java"

src_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/target/${PN}.jar
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc "${S}"/target/site/apidocs
}

src_test() {
	java-pkg-2_src_test
}