# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2

DESCRIPTION="Unrar java implementation"
HOMEPAGE="https://github.com/edmund-wagner/junrar/"
SRC_URI="https://github.com/edmund-wagner/${PN}/archive/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND="dev-java/commons-logging
	>=dev-java/commons-vfs-2"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.5"

S="${WORKDIR}/${PN}-${P}"

src_compile() {
	local build_dir="${S}"/build
	local dist_dir="${S}"/dist
	local classpath="-classpath $(java-pkg_getjars commons-logging,commons-vfs):${build_dir}:./lib"
	mkdir "${build_dir}" "${dist_dir}" || die

	ejavac ${classpath} -nowarn -d "${build_dir}" $(find unrar/src/main/java -name "*.java") || die

	jar cf "${dist_dir}/${PN}.jar" -C ${build_dir} . || die "jar failed"
}

src_install() {
	java-pkg_dojar "${S}/dist/${PN}.jar"
}
