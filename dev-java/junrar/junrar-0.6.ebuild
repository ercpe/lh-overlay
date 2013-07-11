# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Unrar java implementation"
HOMEPAGE="https://github.com/edmund-wagner/junrar/"
SRC_URI="https://github.com/edmund-wagner/${PN}/archive/${P}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	dev-java/commons-logging
	dev-java/commons-vfs:2"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.5"

S="${WORKDIR}/${PN}-${P}"

EANT_BUILD_XML="unrar/build.xml"
JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="commons-logging commons-vfs-2"

src_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/unrar/build.xml || die
}

src_install() {
	java-pkg_newjar "${S}/unrar/target/${P}.jar" "${PN}.jar"

	use source && java-pkg_dosrc unrar/src/main/java
	use doc && java-pkg_dojavadoc "${S}/unrar/target/site/apidocs"
}
