JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="muCommander is a lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/app-misc/mucommander/mucommander-0.8.4_pre20090324.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=virtual/jdk-1.6*
		dev-java/ant-core
		dev-java/ant-junit
		dev-java/commons-logging
		=dev-java/icu4j-3.8*
		=dev-java/jakarta-oro-2.0*
		=dev-java/jcifs-1.2*
		dev-java/jmdns"

RDEPEND="${DEPEND}"

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
