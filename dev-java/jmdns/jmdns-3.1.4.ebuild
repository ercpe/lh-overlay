# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="JmDNS is an implementation of multi-cast DNS in Java."
SRC_URI="mirror://sourceforge/${PN}/${PF}.tgz"
HOMEPAGE="http://jmdns.sourceforge.net"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

src_prepare() {
	rm "${S}"/lib/*.jar || die
}

src_install() {
	java-pkg_dojar lib/jmdns*.jar
	dodoc {README,CHANGELOG,NOTICE}.txt

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/{com,javax}

	use examples && java-pkg_doexamples src/samples
}
