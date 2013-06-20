# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.${PN}.org/dist/${P}.tar.gz
	http://gentoo.j-schmitz.net/overlays/last-hope/${CATEGORY}/${PN}/${P}-build-scripts.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="simple log4j nop jcl"

RDEPEND="${CDEPEND}
	log4j? ( dev-java/log4j )
	jcl? ( dev-java/commons-logging )
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5
	dev-java/java-config"

S="${WORKDIR}/${P}"

JAVA_ANT_REWRITE_CLASSPATH="yes"

src_prepare() {
	_remove_target() {
		sed -i -e "s/.*slf4j-${1}.*//g" "${S}"/build.xml || die
	}
	use simple || _remove_target "simple"
	use nop || _remove_target "nop"
	use jcl || _remove_target "jcl"
	use log4j || _remove_target "log4j12"
}

src_compile() {
	use jcl && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH} commons-logging"
	use log4j && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH} log4j"
	java-pkg-2_src_compile
}

src_install() {
	_inst() {
		java-pkg_newjar "${PN}-${1}/target/${PN}-${1}-${PV}.jar" "${PN}-${1}.jar"
	}
	_inst "api"
	use simple && _inst "simple"
	use nop && _inst "nop"
	use jcl && _inst "jcl"
	use log4j && _inst "log4j12"

	use doc && java-pkg_dohtml -r "${S}/apidocs"
}
