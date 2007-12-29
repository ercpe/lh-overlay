inherit eutils

DESCRIPTION="temerge script for emerge with tmpfs"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sys-apps/temerge/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="stay"
RESTRICT="primaryuri"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}


src_install() {
	mkdir -p "${D}/usr/lib/temerge/"
	if use stay; then
		cp temerge_stay.sh "${D}/usr/lib/temerge/temerge.sh"
	else
		cp temerge_notstay.sh "${D}/usr/lib/temerge/temerge.sh"
	fi
	chmod +x "${D}/usr/lib/temerge/temerge.sh"
	mkdir -p ${D}/usr/bin
	cd ${D}/usr/bin && ln -nfs ${D}/usr/lib/temerge/temerge.sh temerge
}


