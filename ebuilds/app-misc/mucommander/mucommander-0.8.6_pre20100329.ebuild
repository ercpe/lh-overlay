EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/app-misc/mucommander/${PF}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.6
		dev-java/ant-core:0
		dev-java/ant-junit:0"
		

RDEPEND="${DEPEND}
	>=virtual/jre-1.5
	>=dev-java/commons-collections-3.2.1
	dev-java/commons-httpclient:3
	dev-java/commons-codec
	>=dev-java/jmdns-3.1
	dev-java/jcifs:1.1
	dev-java/commons-logging:0
	dev-java/icu4j:0
	dev-java/jakarta-oro:2.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-pkg_jar-from --build-only ant-core
}

src_compile() {
	ANT_OPTS="${ANT_OPTS} -Xmx256m"

	cd lib/include/

	# remove bundled libs (not all, some are patched!) 
	rm {commons-logging.jar,commons-collections.jar,commons-httpclient.jar,commons-codec.jar,icu4j.jar,jakarta-oro.jar,jcifs.jar,jmdns.jar}

	# now link the dependencies
	for x in ant-core ant-junit commons-logging commons-collections commons-httpclient-3 icu4j \
				commons-codec jmdns jakarta-oro-2.0 jcifs-1.1; do
		java-pkg_jar-from "${x}"					
	done

	cd "${S}"

	eant tgz || die "Could not compile"
}

src_install() {
	java-pkg_dojar dist/mucommander.jar

	use source && java-pkg_dosrc source/

	## create a launcher
	java-pkg_dolauncher

	dodoc readme.txt

	newicon res/images/mucommander/icon32_24.png ${PN}.png
	make_desktop_entry ${PN} "muCommander" ${PN}
}
