# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A comprehensive programming and configuration model for modern Java-based enterprise applications"
HOMEPAGE="http://www.springsource.org/spring-framework"
SRC_URI="https://github.com/SpringSource/spring-framework/archive/v${PV}.RELEASE.tar.gz -> spring-framework-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RESTRICT="test" # tests require jdk 1.7

CDEPEND="
	dev-java/commons-logging:0
	dev-java/spring-core:0
	java-virtuals/servlet-api:3.0
	dev-java/javax-inject:0
"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}/spring-framework-${PV}.RELEASE/"

EANT_BUILD_XML=${S}/${PN}/build.xml
JAVA_ANT_REWRITE_CLASSPATH="true"

EANT_GENTOO_CLASSPATH="spring-core,commons-logging,servlet-api-3.0,javax-inject"

java_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/spring-beans/build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/${PN}/dist/${PN}.jar

	use source && java-pkg_dosrc "${S}"/${PN}/src/main/java/org/
	use doc && java-pkg_dojavadoc "${S}"/${PN}/dist/apidocs/
}
