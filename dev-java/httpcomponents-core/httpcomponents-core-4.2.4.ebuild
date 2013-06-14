# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2 

DESCRIPTION="A low level toolset of Java components focused on HTTP and associated protocols"
HOMEPAGE="http://hc.apache.org/index.html"
SRC_URI="mirror://apache/${PN/-//http}/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

EANT_BUILD_TARGET="package"

#EANT_GENTOO_CLASSPATH="${S}/httpcore/target/httpcore-4.2.4.jar"

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
}
