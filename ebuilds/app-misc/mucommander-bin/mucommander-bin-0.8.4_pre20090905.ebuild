EAPI="2"

JAVA_PKG_IUSE=""

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}-${PV//./_}"

DESCRIPTION="Lightweight file manager featuring a Norton Commander style interface"
HOMEPAGE="http://www.mucommander.com"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.5"

RDEPEND="${DEPEND} >=virtual/jre-1.5 !app-misc/mucommander"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	# nothing to do
	echo ""
}

src_install() {
	java-pkg_dojar mucommander.jar

	## create a launcher
	java-pkg_dolauncher mucommander --java_args "-Djava.system.class.loader=com.mucommander.file.AbstractFileClassLoader"

	dodoc readme.txt

#	newicon res/images/about.png ${PN}.png
#	make_desktop_entry ${PN} "muCommander" ${PN}
}
