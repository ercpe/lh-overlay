# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple vcs-snapshot

GITHUB_USER="cbeust"

DESCRIPTION="Command line parsing framework for Java"
HOMEPAGE="https://github.com/cbeust/jcommander"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1.19"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

JAVA_SRC_DIR="src/main/java/"

S="${WORKDIR}"/${P}

RESTRICT="test" # causes a circ. dep: testng <> jcommander

java_prepare() {
	rm pom.xml || die
}

src_install() {
	java-pkg-simple_src_install
	dodoc README.markdown CHANGELOG
}
