# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Implementation of the JSR-330: Dependency Injection for Java"
HOMEPAGE="https://code.google.com/p/atinject/"
SRC_URI="https://${PN}.googlecode.com/files/javax.inject-tck.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/javax-inject:0
	dev-java/junit:4"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

JAVA_GENTOO_CLASSPATH="javax-inject,junit-4"

src_unpack() {
	default
	jar xf javax.inject-tck-src.zip || die
}
