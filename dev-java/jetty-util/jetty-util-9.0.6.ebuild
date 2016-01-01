# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple java-osgi

DESCRIPTION="Eclipse Jetty Servlet"
HOMEPAGE="http://www.eclipse.org/jetty/"
LICENSE="Apache-2.0 EPL-1.0"

BUILD_DATE="20130930"

MY_PV="${PV}.v${BUILD_DATE}"
MY_P="${PN}-${MY_PV}"

SRC_URI="http://repo1.maven.org/maven2/org/eclipse/jetty/${PN}/${MY_PV}/${MY_P}-sources.jar"
SLOT="9"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

COMMON_DEPEND="java-virtuals/servlet-api:3.0
	dev-java/slf4j-api:0"

DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.7"

RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.7"

JAVA_GENTOO_CLASSPATH="servlet-api-3.0,slf4j-api"

src_install() {
	java-osgi_newjar-fromfile ${PN}.jar META-INF/MANIFEST.MF org.eclipse.jetty.util

	use doc && java-pkg_dojavadoc "${S}"/target/api
	use source && java-pkg_dosrc org
}