# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source doc examples"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java implementation of the SSH protocol"
HOMEPAGE="http://sourceforge.net/projects/sshtools/ http://www.sshtools.com/"
SRC_URI="mirror://sourceforge/sshtools/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ant"

CDEPEND="dev-java/commons-logging
	ant? ( dev-java/ant-core )"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5
	dev-java/java-config"

S="${WORKDIR}/${PN}"

EANT_BUILD_TARGET="build"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="commons-logging"

src_prepare() {
	epatch "${FILESDIR}/${PV}-extras.patch"

	if ! use ant; then
		rm -r "${S}/src/com/sshtools/ant" || die
	fi

	sed \
		-e 's/-${j2ssh.version.major}.${j2ssh.version.minor}.${j2ssh.version.build}.jar/.jar/g' \
		-i "${S}/build.xml" || die
}

src_compile() {
	use ant && EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH} ant-core"
	java-pkg-2_src_compile

	if ! use ant; then
		rm -rv "${S}/dist/lib/${PN}-ant.jar" || die
	fi
}

src_install() {
	java-pkg_dojar "${S}"/dist/lib/*.jar

	use doc && java-pkg_dohtml -r docs/
	use source && java-pkg_dosrc "${S}"/src/
	use examples && java-pkg_doexamples "${S}"/examples/
}
