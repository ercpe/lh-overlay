# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/httpcomponents-core/httpcomponents-core-4.2.4.ebuild,v 1.1 2013/07/13 13:38:27 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="source examples test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A low level toolset of Java components focused on HTTP and associated protocols."
HOMEPAGE="http://hc.apache.org/index.html"
SRC_URI="mirror://apache/${PN/-//http}/source/${P}-src.tar.gz
		http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}-build.tar.bz2"

LICENSE="Apache-2.0"
SLOT="4.3"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/commons-logging:0
		dev-java/junit:4
		dev-java/ant-junit4
		dev-java/mockito:0
	)"
RDEPEND=">=virtual/jre-1.5"

EANT_BUILD_TARGET="package"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_TEST_GENTOO_CLASSPATH="junit-4,commons-logging,mockito"
EANT_TEST_ANT_TASKS="ant-junit4"

src_install() {
	java-pkg_dojar httpcore/target/httpcore.jar \
					httpcore-nio/target/httpcore-nio.jar

	use source && java-pkg_dosrc httpcore{,-nio}/src/main/java
	use examples && java-pkg_doexamples httpcore{,-nio}/src/examples

	dodoc {README,RELEASE_NOTES,NOTICE}.txt
}

src_test() {
	java-pkg-2_src_test
}
