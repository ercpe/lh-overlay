EAPI="2"

WANT_ANT_TASKS="ant-commons-logging"
EANT_NEEDS_TOOLS="true"
JAVA_PKG_IUSE="doc source"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="ant-core,ant-junit,commons-logging,icu4j,jmdns,jakarta-oro:2.0,jcifs:1.1"
EANT_BUILD_TARGET="nightly"
ANT_OPTS="${ANT_OPTS} -Xmx256m"

NEEDED_JARS="ant-bzip2.jar commons-net.jar j2ssh.jar jna.jar yanfs.jar"

inherit eutils java-pkg-2 java-ant-2 java-utils-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/app-misc/mucommander/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.6
		dev-java/ant-core:0
		dev-java/ant-junit:0
		dev-java/commons-logging:0
		dev-java/icu4j:0
		dev-java/jakarta-oro:2.0
		dev-java/jcifs:1.1
		dev-java/jmdns:0"

RDEPEND="${DEPEND}
	>=virtual/jre-1.4"


src_unpack() {
	unpack ${A}
	cd "${S}"
	java-pkg_jar-from --build-only ant-core
}


src_compile() {
	ANT_OPTS="${ANT_OPTS} -Xmx256m"

	cd lib/include/

	## remove libs provided by the dependencies
	## commons-net in lib/ is a custom version!
	rm {commons-logging.jar,icu4j.jar,jakarta-oro.jar,jcifs.jar,jmdns.jar}

	## now link the dependencies
	java-pkg_jar-from ant-core
	java-pkg_jar-from ant-junit
	java-pkg_jar-from commons-logging
	java-pkg_jar-from icu4j
	java-pkg_jar-from jmdns
	java-pkg_jar-from jakarta-oro-2.0
	java-pkg_jar-from jcifs-1.1

	cd "${S}"

	eant nightly
}


src_install() {
	java-pkg_dojar dist/mucommander.jar

	## create a launcher
	java-pkg_dolauncher

	dodoc readme.txt

	newicon res/images/about.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
