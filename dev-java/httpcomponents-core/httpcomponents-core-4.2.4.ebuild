# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A low level toolset of Java components focused on HTTP and associated protocols"
HOMEPAGE="http://hc.apache.org/index.html"
SRC_URI="mirror://apache/${PN/-//http}/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_BUILD_TARGET="package"

java_prepare() {
	cp "${FILESDIR}/maven-build.xml" "${S}/build.xml" || die
	for x in "${FILESDIR}"/httpcore*; do
		d=$(basename $x);
		cp "${x}" "${S}"/${d/-build.xml}/build.xml || die
	done
}

src_install() {
	for mod in httpcore httpcore-nio; do
		java-pkg_newjar "${S}/${mod}/target/${mod}-${PV}.jar" ${mod}.jar
	done

	use source && java-pkg_dosrc "${S}/httpcore/src/main/java/" \
		"${S}/httpcore-nio/src/main/java/"

	use examples && java-pkg_doexamples "${S}/httpcore/src/examples/" \
		"${S}/httpcore-nio/src/examples/"
	
	dodoc "${S}"/{README,RELEASE_NOTES,NOTICE}.txt
}
