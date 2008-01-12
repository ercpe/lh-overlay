inherit eutils

DESCRIPTION="wxGTK monitor for the folding@home client"
HOMEPAGE="http://fahmon.silent-blade.org/"
SRC_URI="http://fahmon.silent-blade.org/uploads/Main/${P}.src.tar.bz2"
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
	cd "${WORKDIR}"/FahMon/src
	epatch "${FILESDIR}"/fahmon-fixes.patch
}

src_compile() {
	cd "${WORKDIR}"/FahMon/src
	scons ${MAKEOPTS} || die
}

src_install() {
	cd "${WORKDIR}"/FahMon/src
	dobin fahmon
	dodir /usr/share/fahmon
	cp -R images/ ${D}/usr/share/fahmon/ || die
}
