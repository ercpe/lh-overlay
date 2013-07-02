# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils java-pkg-2

DESCRIPTION="Yet Another NFS - a Java NFS library"
HOMEPAGE="https://java.net/projects/yanfs"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${CATEGORY}/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

src_prepare() {
	epatch "${FILESDIR}/${PV}-fixit.patch"
	rm -r "${S}"/src/com/sun/gssapi/{samples,mechs} || die
	rm -r "${S}"/src/com/sun/rpc/samples || die
}

src_compile() {
	local build_dir="${S}"/classes
	local dist_dir="${S}"/dist
	mkdir ${dist_dir} || die

	CODEMGR_WS="${S}" emake -C "${S}/src/com/sun/gssapi/" || die

	local classpath="-classpath ${build_dir}/com/sun/gssapi/:${build_dir}/com/sun/gssapi/mechs/dummy"
	ejavac ${classpath} -nowarn -d "${build_dir}" $(find src/ -name "*.java")

	jar cf "${dist_dir}/${PN}.jar" -C ${build_dir} . || die "jar failed"
}

src_install() {
	java-pkg_dojar "${S}/dist/${PN}.jar"
}
