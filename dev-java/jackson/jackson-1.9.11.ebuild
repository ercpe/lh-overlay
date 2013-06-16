# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"
EANT_BUILD_TARGET=jars

inherit java-pkg-2 java-ant-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"
SRC_URI="http://jackson.codehaus.org/${PV}/${PN}-src-${PV}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S="${WORKDIR}/${PN}-src-${PV}"

src_install() {
	dodoc README.txt release-notes/{VERSION,CREDITS}
	for i in jaxrs {mapper,core}-{asl,lgpl} ; do
		java-pkg_newjar build/${PN}-${i}-${PV}.jar ${PN}-${i}.jar
	done

	use doc && java-pkg_dohtml -r build/javadoc
	use source && java-pkg_dosrc src/java/org src/jaxrs/java
}

src_test() {
	java-pkg-2_src_test
}