inherit eutils

DESCRIPTION="Setup a 32bit chroot as service"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sys-apps/32bit_chroot/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
RESTRICT="mirror"

src_install() {
	doinitd gentoo_32bit
	doconfd gentoo_32bit.conf
}

pkg_postinst(){
	einfo
	einfo "Remember to add 32bit_chroot to the default runlevel"
	einfo "rc-update add 32bit_chroot default"
	einfo
	einfo "Use this to chroot"
	einfo "linux32 chroot CHROOTDIR /bin/bash"
	einfo
}
