# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java implementation of the SSH protocol"
HOMEPAGE="http://sourceforge.net/projects/sshtools/ http://www.sshtools.com/"
SRC_URI="mirror://sourceforge/sshtools/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ant"

CDEPEND="dev-java/commons-logging
	ant? ( dev-java/ant-core )"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5
	dev-java/java-config"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PV}-extras.patch"
	cd "${S}/lib/" || die
	rm "commons-logging.jar" || die
	java-pkg_jar-from commons-logging

	if use ant; then
		java-pkg_jar-from ant-core
	else
		rm -r "${S}/src/com/sshtools/ant" || die
	fi

	sed -i -e 's/-${j2ssh.version.major}.${j2ssh.version.minor}.${j2ssh.version.build}.jar/.jar/g' \
		"${S}/build.xml" || die
}

src_compile() {
	eant build

	use ant || ( rm -r "${S}/dist/lib/${PN}-ant.jar" || die )
}

src_install() {
	java-pkg_dojar ${S}/dist/lib/*.jar
}
