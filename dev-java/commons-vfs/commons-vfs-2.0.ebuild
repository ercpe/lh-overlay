# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="a single API for accessing various different file systems"
HOMEPAGE="http://commons.apache.org/vfs/"
SRC_URI="mirror://apache/${PN/-//}/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="
	dev-java/commons-logging
	>dev-java/commons-net-2
	=dev-java/commons-httpclient-3*
	>=dev-java/jsch-0.1.42
	dev-java/commons-collections
	dev-java/ant-core
	dev-java/jackrabbit-bin:1"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${P}"

src_compile() {
	local build_dir="${S}"/build
	local dist_dir="${S}"/gdist
	local classpath="-classpath $(java-pkg_getjars commons-logging,commons-net,commons-httpclient-3,jsch,commons-collections,ant-core,jackrabbit-bin):${build_dir}:./lib"
	mkdir "${build_dir}" "${dist_dir}" || die

	ejavac ${classpath} -nowarn -d "${build_dir}" $(find core/src/main/java -name "*.java") || die

	jar cf "${dist_dir}/${PN}.jar" -C ${build_dir} . || die "jar failed"
}

src_install() {
	java-pkg_dojar "${S}/gdist/${PN}.jar"
}
