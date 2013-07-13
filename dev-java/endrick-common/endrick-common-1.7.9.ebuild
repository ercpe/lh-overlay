# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java cache library"
HOMEPAGE="http://svn.ettrema.com/svn/endrick/tags/endrick-1.7.9/endrick-cache/"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/slf4j-api
	>dev-java/jdom-1.1
	dev-java/log4j"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

EANT_GENTOO_CLASSPATH="slf4j-api
	jdom-1.1
	log4j"
JAVA_ANT_REWRITE_CLASSPATH="yes"

src_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die
	rm -r "${S}/src/test" || die
}

src_install() {
	java-pkg_dojar "${S}"/dist/${PN}.jar
}
