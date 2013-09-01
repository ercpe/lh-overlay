# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="5"

JAVA_PKG_IUSE="test doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
HOMEPAGE="http://cglib.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/asm:4
	>=dev-java/ant-core-1.7.0"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	test? ( dev-java/junit:0 )
	${COMMON_DEP}"

S=${WORKDIR}

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="asm-4 ant-core"

java_prepare() {
	find . -iname '*.jar' -print0 | xargs -0 rm -v
	epatch "${FILESDIR}"/${P}-build.xml.patch
}

EANT_TEST_EXTRA_ARGS="-Dcglib.debugLocation=${T}/debug"

src_test() {
	mkdir "${T}/debug"
	cp -v "${FILESDIR}/words.txt" "${S}/src/test/net/sf/cglib/util/"
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	dodoc NOTICE README || die
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/proxy/net
	use examples && java-pkg_doexamples --subdir samples src/proxy/samples
}