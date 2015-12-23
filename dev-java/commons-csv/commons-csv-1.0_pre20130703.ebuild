# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Read and write files in variations of the Comma Separated Value (CSV) format"
HOMEPAGE="http://commons.apache.org/proper/commons-csv/"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

src_prepare() {
	cp "${FILESDIR}/${PV}-build.xml" "${S}"/build.xml || die
}

src_install() {
	java-pkg_newjar "${S}"/target/${PN}-${PV/_*}-SNAPSHOT.jar "${PN}.jar"

	use doc && java-pkg_dojavadoc "${S}"/target/site/apidocs
	use source && java-pkg_dosrc "${S}"/src/
}
