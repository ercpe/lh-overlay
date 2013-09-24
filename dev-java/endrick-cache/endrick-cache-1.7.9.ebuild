# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java cache library"
HOMEPAGE="http://svn.ettrema.com/svn/endrick/tags/endrick-1.7.9/endrick-cache/"
SRC_URI="http://dev.gentoo.org/~ercpe/distfiles/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/slf4j-api
	=dev-java/endrick-common-${PV}
	dev-java/kryo:1
	dev-db/db-je:3.3"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${P}"

JAVA_GENTOO_CLASSPATH="slf4j-api,endrick-common,db-je-3.3,kryo-1"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	rm "${S}"/pom.xml || die
	find -name "*Test*.java" -delete || die
}
