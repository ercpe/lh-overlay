inherit eutils

DESCRIPTION="wxGTK monitor for the folding@home client"
HOMEPAGE="http://fahmon.net/"
SRC_URI="http://fahmon.net/downloads/FahMon-2.3.1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/wxGTK-2.6.3"
DEPEND="dev-util/scons
	${RDEPEND}"

pkg_setup() {
	if built_with_use x11-libs/wxGTK debug ; then
		die "wxGTK must be built with USE='-debug'"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"/FahMon-2.3.1/src
	epatch "${FILESDIR}"/fahmon-fixes.patch
}

src_compile() {
	cd "${WORKDIR}"/FahMon-2.3.1/src
	scons ${MAKEOPTS} || die
}

src_install() {
	cd "${WORKDIR}"/FahMon-2.3.1/src
	dobin fahmon
	dodir /usr/share/fahmon
	cp -R images/ ${D}/usr/share/fahmon/ || die
}
