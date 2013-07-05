# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Alibraries which allows to write modular applications which can run both standalone and inside "
HOMEPAGE="https://code.google.com/p/eclipsito/"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

src_prepare() {
	epatch "${FILESDIR}/${PV}-build.xml"
}

src_install() {
	java-pkg_dojar "${S}"/eclipsito.jar

	use doc && java-pkg_dojavadoc "${S}"/apidocs
	use source && java-pkg_dosrc "${S}"/src/
}
