# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmdns/jmdns-1.0.ebuild,v 1.5 2009/05/23 21:10:26 ali_bush Exp $

EAPI="2"

JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="JmDNS is an implementation of multi-cast DNS in Java."
SRC_URI="mirror://sourceforge/${PN}/${PF}.tgz"
HOMEPAGE="http://jmdns.sourceforge.net"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm lib/*.jar
}

src_compile() {
	eant jar || die "Could not compile"
}

src_install() {
	java-pkg_dojar lib/jmdns*.jar
	dodoc README.txt CHANGELOG.txt

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/{com,javax}

	if use examples; then
		insinto /usr/share/doc/${P}/
		doins -r src/samples
	fi
}
