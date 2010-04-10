# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#WANT_ANT_TASKS="ant-commons-net"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="A simple but powerfull backup solution written in java"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/app-admin/jbackup/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

COMMONS_DEPEND="
	dev-java/commons-cli:1
	dev-java/log4j:0
	dev-java/cglib:2.2
	dev-java/commons-net
	=dev-java/commons-lib-1.2.7
	>=dev-java/xstream-1.3"

RDEPEND="
	virtual/jre:1.6
	${COMMONS_DEPEND}"
DEPEND="
	virtual/jdk:1.6
	${COMMONS_DEPEND}"

RESTRICT="mirror"

JAVA_ANT_ENCODING=UTF-8

EANT_BUILD_TARGET="build-dist"
use debug && EANT_BUILD_TARGET="build-dist-debug"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="cglib-2.2,commons-cli-1,commons-net,log4j,xpp3,xstream,commons-lib"

src_install() {
	java-pkg_dojar release/jbackup.jar

	java-pkg_dolauncher ${PN} --main net.jschmitz.jbackup.Startup

	use source && java-pkg_dosource source
}
