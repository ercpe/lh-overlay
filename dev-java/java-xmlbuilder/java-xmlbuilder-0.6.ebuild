# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2 java-ant-2 subversion

DESCRIPTION="A utility that allows simple XML documents to be constructed using Java"
HOMEPAGE="https://code.google.com/p/java-xmlbuilder/"
SRC_URI=""
ESVN_REPO_URI="http://${PN}.googlecode.com/svn/tags/${P}/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/base64"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="base64"

src_prepare() {
	cp "${FILESDIR}/${PV}-maven-build.xml" "${S}/build.xml" || die
}

src_install() {
	java-pkg_newjar "${S}/target/${P}.jar" ${PN}.jar
}

