#EAPI=1

JAVA_PKG_IUSE="doc source"
#WANT_ANT_TASKS="ant-core"

inherit subversion java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="mucommander"
HOMEPAGE="http://www.mucommander.com"
ESVN_REPO_URI="https://svn.${PN}.com/${PN}/tags/release_${PV//./_}"

LICENSE="GPL-2"
SLOT="0"
# KEYWORDS=""
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

#S="${WORKDIR}/${P}"

src_unpack(){
	subversion_src_unpack
	java-pkg_jar-from --build-only ant-core
}


src_compile(){
	cd lib/include/
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit

	cd ../..
	eant nightly
}


src_install() {
	insinto /usr/share/mucommander/
	newins dist/mucommander.jar mucommander.jar

	exeinto /usr/bin
	doexe ${FILESDIR}/mucommander
}
