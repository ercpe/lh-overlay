# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="a single API for accessing various different file systems"
HOMEPAGE="http://commons.apache.org/vfs/"
SRC_URI="mirror://apache/${PN/-//}/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

COMMON_DEP="
	dev-java/commons-logging
	>dev-java/commons-net-2
	=dev-java/commons-httpclient-3*
	>=dev-java/jsch-0.1.42
	dev-java/commons-collections
	dev-java/ant-core
	dev-java/jackrabbit-bin:1"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${P}"

EANT_BUILD_XML="core/build.xml"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="
	commons-collections
	commons-httpclient-3
	commons-logging
	commons-net
	jackrabbit-bin-1
	jsch"

src_compile() {
	EANT_BUILD_TARGET="jar"
	use doc && EANT_BUILD_TARGET="${EANT_BUILD_TARGET} javadoc"
	java-pkg-2_src_compile
}

src_prepare() {
	cp "${FILESDIR}/${PV}-core-build.xml" "${S}"/core/build.xml || die
}

src_install() {
	java-pkg_newjar "${S}/core/target/${PN}2-${PV}.jar" "${PN}.jar"

	use doc && java-pkg_dohtml -r "${S}/core/target/site/apidocs"
	use source && java-pkg_dosrc "${S}/core/src/main/java/"
	use examples && java-pkg_doexamples "${S}/examples/src/main/java/"

	dodoc "${S}"/{README,NOTICE,RELEASE-NOTES}.txt
}
