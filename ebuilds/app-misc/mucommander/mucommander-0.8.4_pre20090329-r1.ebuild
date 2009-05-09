EAPI="2"

JAVA_PKG_IUSE="doc source"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="ant-core,ant-junit,commons-logging,icu4j,jmdns,jakarta-oro-2.0,jcifs-1.1"
EANT_BUILD_TARGET="nightly"
ANT_OPTS="${ANT_OPTS} -Xmx256m"

NEEDED_JARS="ant-bzip2.jar commons-net.jar j2ssh.jar jna.jar yanfs.jar"

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/app-misc/mucommander/mucommander-0.8.4_pre20090329.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core:0
		dev-java/ant-junit:0
		dev-java/commons-logging:0
		dev-java/icu4j:0
		dev-java/jakarta-oro:2.0
		dev-java/jcifs:1.1
		dev-java/jmdns:0"

RDEPEND="${DEPEND}
	=virtual/jre-1.6*"

src_prepare() {
	java-pkg_jar-from --build-only ant-core

	cd lib/include/

	for jar in *.jar ;do
		has ${jar} "${NEEDED_JARS}" || \
		{  rm -v ${jar} || die; }
	done
}


src_install() {
	java-pkg_dojar dist/mucommander.jar

	## create a launcher
	java-pkg_dolauncher

	dodoc readme.txt

	newicon res/images/about.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
